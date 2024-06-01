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
          'body': 'https://www.google.com/search?q=linkin&rlz=1C1KNTJ_enMY1080MY1080&oq=linkin&gs_lcrp=EgZjaHJvbWUyBggAEEUYOTIMCAEQLhhDGIAEGIoFMgwIAhAAGAoYsQMYgAQyBwgDEAAYgAQyBwgEEAAYgAQyBwgFEAAYgAQyEggGEC4YChjHARixAxjRAxiABDIGCAcQBRhA0gEINDc4NGoxajeoAgCwAgA&sourceid=chrome&ie=UTF-8',
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
    } else {
      print('Error sending notification: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }
}
