import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostInsightController extends GetxController {
  static PostInsightController instance = Get.find();
  DateTime? lastEmailSentTime;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var candidates = <Map<String, dynamic>>[].obs;
  var email = ''.obs;
  var deviceToken = ''.obs;

  // Future<void> savePostInsight(String jobPostId) async {
  //   final now = DateTime.now(); // Replace with your project ID
  //   print("This is date time $now");
  //   final month = now.month;

  //   final docRef =
  //       FirebaseFirestore.instance.collection('jobPost').doc(jobPostId);
  //   final doc = await docRef.get();

  //   if (doc.exists) {
  //     // print(doc.data());
  //     final insightData = doc.data()?["insight"];
  //     print("This is data after fetching $insightData");
  //   }

  //   print("This is date time month $month");
  // final month = now.month;
  // final day = now.day;
  // final Map<String, dynamic> postInsight = {
  //   'insight': {
  //     'impression': {
  //       '$month': {
  //         '$day': {
  //           'dayDate': "$day",
  //           'value': "123",
  //         },
  //         '$day': {
  //           'dayDate': "$day",
  //           'value': "123",
  //         },
  //       },
  //     },
  //     'clicks': {
  //       '$month': {
  //         '$day': {
  //           'dayDate': "$day",
  //           'value': "123",
  //         },
  //         '$day': {
  //           'dayDate': "$day",
  //           'value': "123",
  //         },
  //       },
  //     },
  //     'apply': {
  //       '$month': {
  //         '$day': {
  //           'dayDate': "$day",
  //           'value': "123",
  //         },
  //         '$day': {
  //           'dayDate': "$day",
  //           'value': "123",
  //         },
  //       },
  //     },
  //   }
  // };

  //   print(jsonEncode(postInsight));
  //   // final http.Response response = await http.post(
  //   //   fcmUrl,
  //   //   headers: headers,
  //   //   body: jsonEncode(notification),
  //   // );
  // }
  Future<Map<String, dynamic>> fetchPostInsight(String jobPostId) async {
    final docRef =
        FirebaseFirestore.instance.collection('jobPost').doc(jobPostId);

    try {
      final doc = await docRef.get();
      if (doc.exists && doc.data() != null && doc.data()!['insight'] != null) {
        final insightJsonString = doc.data()!['insight'];
        if (insightJsonString is String) {
          return jsonDecode(insightJsonString) as Map<String, dynamic>;
        } else if (insightJsonString is Map) {
          return Map<String, dynamic>.from(insightJsonString);
        }
      }
    } catch (e) {
      print("Failed to fetch insight data: $e");
    }

    return {};
  }

  Future<void> savePostInsight(String jobPostId) async {
    final now =
        DateTime.utc(1989, 3, 12); // Replace with current date in production
    final month = now.month;
    final day = now.day;

    final docRef =
        FirebaseFirestore.instance.collection('jobPost').doc(jobPostId);

    try {
      final doc = await docRef.get();
      Map<String, dynamic> insightData = {};

      // Fetch existing insight data
      if (doc.exists && doc.data() != null && doc.data()!['insight'] != null) {
        final insightJsonString = doc.data()!['insight'];
        if (insightJsonString is String) {
          insightData = jsonDecode(insightJsonString) as Map<String, dynamic>;
        } else if (insightJsonString is Map) {
          insightData = Map<String, dynamic>.from(insightJsonString);
        }
      }

      print("This is data after fetching: $insightData");

      // Calculate new values
      final int impressionValue = (int.tryParse(insightData['impression']
                      ?['$month']?['$day']?['value'] ??
                  "0") ??
              0) +
          1;
      final int clicksValue = (int.tryParse(
                  insightData['clicks']?['$month']?['$day']?['value'] ?? "0") ??
              0) +
          1;
      final int applyValue = (int.tryParse(
                  insightData['apply']?['$month']?['$day']?['value'] ?? "0") ??
              0) +
          1;

      // Update the insight data for the current month and day
      insightData['impression'] = {
        ...insightData['impression'] ?? {},
        '$month': {
          ...insightData['impression']?['$month'] ?? {},
          '$day': {
            'dayDate': "$day",
            'value': impressionValue.toString(),
          },
        },
      };
      insightData['clicks'] = {
        ...insightData['clicks'] ?? {},
        '$month': {
          ...insightData['clicks']?['$month'] ?? {},
          '$day': {
            'dayDate': "$day",
            'value': clicksValue.toString(),
          },
        },
      };
      insightData['apply'] = {
        ...insightData['apply'] ?? {},
        '$month': {
          ...insightData['apply']?['$month'] ?? {},
          '$day': {
            'dayDate': "$day",
            'value': applyValue.toString(),
          },
        },
      };

      print(jsonEncode(insightData));

      // Save the updated insight data back to Firestore
      final jsonString = jsonEncode(insightData);
      await docRef.set({'insight': jsonString}, SetOptions(merge: true));
      print("Insight data successfully updated.");
    } catch (e) {
      print("Failed to update insight data: $e");
    }
  }

  String getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }

  Future<void> addToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('userEmail') ?? '';

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('user').doc(email.toLowerCase());

    await documentReference.update({
      'Token': token,
    });

    deviceToken.value = token;
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  String getEmail() {
    return email.value;
  }

  String getDeviceToken() {
    return deviceToken.value;
  }
}
