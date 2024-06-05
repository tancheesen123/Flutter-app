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
    // Load the service account credentials from the JSON file
    final String credentialsJson = await rootBundle.loadString(
        'assets/config/flutter-mango-firebase-adminsdk-bj9c2-dbc3986369.json');
    final serviceAccountCredentials = ServiceAccountCredentials.fromJson(
      json.decode(credentialsJson),
    );

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

  Future<void> sendNotification(String deviceToken) async {
    final String projectId = 'flutter-mango'; // Replace with your project ID

    // Get the OAuth token
    final String oauthToken = await getOAuthToken();

    final Uri fcmUrl = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send');

    final Map<String, dynamic> notification = {
      'message': {
        'token': deviceToken,
        'data': {}, // Add any custom data here
        'notification': {
          'title': 'Test',
          'body':
              'https://www.google.com/search?q=linkin&rlz=1C1KNTJ_enMY1080MY1080&oq=linkin&gs_lcrp=EgZjaHJvbWUyBggAEEUYOTIMCAEQLhhDGIAEGIoFMgwIAhAAGAoYsQMYgAQyBwgDEAAYgAQyBwgEEAAYgAQyBwgFEAAYgAQyEggGEC4YChjHARixAxjRAxiABDIGCAcQBRhA0gEINDc4NGoxajeoAgCwAgA&sourceid=chrome&ie=UTF-8',
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
      saveNotification(notification);
      // how to get id, title and body value?
      // print(' Encode notification: ${jsonEncode(notification)}');
      // String jsonString = jsonEncode(notification);
      // final Map<String, dynamic> data = jsonDecode(jsonString);
      // print("Decode notification $data");

      // final String token = notification['message']['token'];
      // final String title = notification['message']['notification']['title'];
      // final String body = notification['message']['notification']['body'];

      // print('Token: $token');
      // print('Title: $title');
      // print('Body: $body');
    } else {
      print('Error sending notification: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  Future<void> saveNotification(Map<String, dynamic> notification) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('userEmail') ?? '';

    if (email.isEmpty) {
      print('User email not found in SharedPreferences');
      return;
    }

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

    // Retrieve the documents from the collection
    QuerySnapshot snapshot = await notificationCollection
        .orderBy('timestamp', descending: true)
        .get();

    // Parse the documents into a list of maps
    List<Map<String, dynamic>> notifications = snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();

    print('Fetched ${notifications.length} notifications.');
    return notifications;
  }

  Future<List<Map<String, dynamic>>> fetchActiveNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('userEmail') ?? '';

    // Reference to the user's notification collection
    CollectionReference notificationCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(email.toLowerCase())
        .collection('Notification');

    // Retrieve the documents from the collection
    QuerySnapshot snapshot =
        await notificationCollection.where('status', isEqualTo: 'active').get();

    // Parse the documents into a list of maps
    List<Map<String, dynamic>> notifications = snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();
    return notifications;
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
