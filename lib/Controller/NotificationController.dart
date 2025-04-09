import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';

class NotificationController extends GetxController {
  static NotificationController instance = Get.find();
  DateTime? lastEmailSentTime;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var candidates = <Map<String, dynamic>>[].obs;
  var email = ''.obs;

  Future<String> getOAuthToken() async {
    // Load service account credentials from environment variables
    final serviceAccountCredentials = ServiceAccountCredentials.fromJson({
      'type': 'service_account',
      'project_id': Platform.environment['FIREBASE_PROJECT_ID'],
      'private_key_id': Platform.environment['FIREBASE_PRIVATE_KEY_ID'],
      'private_key': Platform.environment['FIREBASE_PRIVATE_KEY']?.replaceAll(r'\n', '\n'),
      'client_email': Platform.environment['FIREBASE_CLIENT_EMAIL'],
      'client_id': Platform.environment['FIREBASE_CLIENT_ID'],
      'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
      'token_uri': 'https://oauth2.googleapis.com/token',
      'auth_provider_x509_cert_url': 'https://www.googleapis.com/oauth2/v1/certs',
      'client_x509_cert_url': Platform.environment['FIREBASE_CLIENT_CERT_URL']
    });

    // Define the required scopes
    final List<String> scopes = [
      'https://www.googleapis.com/auth/cloud-platform'
    ];

    // Obtain an authenticated HTTP client
    final AuthClient client =
        await clientViaServiceAccount(serviceAccountCredentials, scopes);

    // Obtain the OAuth token
    final AccessCredentials credentials = await client.credentials;
    return credentials.accessToken.data;
  }

  Future<void> sendNotification(
      String deviceToken, String title, String body, String email) async {
    final String projectId = Platform.environment['FIREBASE_PROJECT_ID'] ?? 'flutter-mango';

    // Get the OAuth token
    final String oauthToken = await getOAuthToken();

    final Uri fcmUrl = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send');

    final Map<String, dynamic> notification = {
      'message': {
        'token': deviceToken,
        'data': {}, // Add any custom data here
        'notification': {
          'title': title,
          'body': body,
        },
      }
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $oauthToken', // Use OAuth token here
    };

    final http.Response response = await http.post(
      fcmUrl,
      headers: headers,
      body: jsonEncode(notification),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
      saveNotification(notification, email);
    } else {
      print('Error sending notification: ${response.statusCode}');
      print('Response: ${response.body}');
      throw Exception('Failed to send notification: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> saveNotification(
      Map<String, dynamic> notification, String email) async {
    String jsonString = jsonEncode(notification);

    // Reference to the user's notification collection
    CollectionReference notificationCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(email.toLowerCase())
        .collection('Notification');

    // Check if the collection has any documents
    QuerySnapshot snapshot = await notificationCollection.get();

    if (snapshot.docs.isEmpty) {
      print(
          'Notification collection does not exist or is empty. It will be created.');
    } else {
      print(
          'Notification collection exists with ${snapshot.docs.length} documents.');
    }

    // Generate a new document reference with a unique ID
    DocumentReference documentReference = notificationCollection.doc();

    // Save the notification JSON string to the document
    await documentReference.set({
      'notification': jsonString,
      'timestamp': FieldValue.serverTimestamp(),
      'status': "active" // Optional: add a timestamp
    });

    print('Notification saved successfully');
  }

  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('userEmail') ?? '';

      if (email.isEmpty) {
        print('User email not found in SharedPreferences');
        return [];
      }

      // Reference to the user's notification collection
      CollectionReference notificationCollection = FirebaseFirestore.instance
          .collection('user')
          .doc(email.toLowerCase())
          .collection('Notification');

      // Retrieve the documents from the collection with a timeout
      QuerySnapshot snapshot = await notificationCollection
          .orderBy('timestamp', descending: true)
          .get(GetOptions(source: Source.serverAndCache))
          .timeout(const Duration(seconds: 10));

      // Parse the documents into a list of maps
      List<Map<String, dynamic>> notifications = snapshot.docs.map((doc) {
        try {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        } catch (e) {
          print('Error parsing notification document ${doc.id}: $e');
          return {'error': 'Failed to parse notification'};
        }
      }).toList();

      print('Successfully fetched ${notifications.length} notifications.');
      return notifications.where((n) => !n.containsKey('error')).toList();
    } catch (e) {
      print('Error fetching notifications: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchActiveNotifications() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('userEmail') ?? '';

      if (email.isEmpty) {
        print('User email not found in SharedPreferences');
        return [];
      }

      // Reference to the user's notification collection
      CollectionReference notificationCollection = FirebaseFirestore.instance
          .collection('user')
          .doc(email.toLowerCase())
          .collection('Notification');

      // Retrieve active notifications with cache fallback
      QuerySnapshot snapshot = await notificationCollection
          .where('status', isEqualTo: 'active')
          .get(GetOptions(source: Source.serverAndCache))
          .timeout(const Duration(seconds: 10));

      // Parse and validate documents
      List<Map<String, dynamic>> notifications = snapshot.docs.map((doc) {
        try {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        } catch (e) {
          print('Error parsing active notification ${doc.id}: $e');
          return {'error': 'Failed to parse notification'};
        }
      }).toList();

      print('Fetched ${notifications.length} active notifications.');
      return notifications.where((n) => !n.containsKey('error')).toList();
    } catch (e) {
      print('Error fetching active notifications: $e');
      rethrow;
    }
  }

  Future<void> updateStatus(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('userEmail') ?? '';

    if (email.isEmpty) {
      print('User email not found in SharedPreferences');
      return;
    }

    // Reference to the specific document in the user's notification collection
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('user')
        .doc(email.toLowerCase())
        .collection('Notification')
        .doc(id);

    // Check if the document exists
    DocumentSnapshot snapshot = await documentReference.get();

    if (!snapshot.exists) {
      print('Notification document does not exist.');
      return;
    }

    // Update the status field of the document
    await documentReference.update({
      'status': "clicked", // Update the status field
    });

    print('Notification status updated successfully');
  }
}
