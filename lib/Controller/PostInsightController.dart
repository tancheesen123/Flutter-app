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

  Future<void> saveImpression(String jobPostId) async {
    await updateInsight(jobPostId, 'impression');
  }

  Future<void> saveClicks(String jobPostId) async {
    await updateInsight(jobPostId, 'clicks');
  }

  Future<void> saveApply(String jobPostId) async {
    await updateInsight(jobPostId, 'apply');
  }

  Future<void> updateInsight(String jobPostId, String field) async {
    // final now = DateTime.now(); // Replace with current date in production
    final now = DateTime.utc(1989, 3, 12);
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

      // Calculate new value
      final int newValue = (int.tryParse(
                  insightData[field]?['$month']?['$day']?['value'] ?? "0") ??
              0) +
          1;

      // Update the insight data for the current month and day
      if (insightData[field] == null) {
        insightData[field] = {};
      }
      if (insightData[field]['$month'] == null) {
        insightData[field]['$month'] = {};
      }

      insightData[field]['$month']['$day'] = {
        'dayDate': "$day",
        'value': newValue.toString(),
      };

      print(jsonEncode(insightData));

      // Save the updated insight data back to Firestore
      final jsonString = jsonEncode(insightData);
      await docRef.set({'insight': jsonString}, SetOptions(merge: true));
      print("Insight data successfully updated for $field.");
    } catch (e) {
      print("Failed to update insight data for $field: $e");
    }
  }

  Future<void> initializeInsight(String jobPostId) async {
    final now = DateTime.now(); // Replace with current date in production
    final month = now.month;
    final day = now.day;

    final docRef =
        FirebaseFirestore.instance.collection('jobPost').doc(jobPostId);

    try {
      Map<String, dynamic> insightData = {
        'impression': {
          '$month': {
            '$day': {
              'dayDate': "$day",
              'value': "0",
            },
          },
        },
        'clicks': {
          '$month': {
            '$day': {
              'dayDate': "$day",
              'value': "0",
            },
          },
        },
        'apply': {
          '$month': {
            '$day': {
              'dayDate': "$day",
              'value': "0",
            },
          },
        },
      };

      final jsonString = jsonEncode(insightData);
      await docRef.set({'insight': jsonString}, SetOptions(merge: true));
      print("Insight data successfully initialized.");
    } catch (e) {
      print("Failed to initialize insight data: $e");
    }
  }

  Future<void> createInsight(String jobPostId) async {
    await initializeInsight(jobPostId);
    // await saveImpression(jobPostId);
    // await saveClicks(jobPostId);
    // await saveApply(jobPostId);
  }

  Future<Map<String, int>> getTotalValues(String jobPostId) async {
    final docRef =
        FirebaseFirestore.instance.collection('jobPost').doc(jobPostId);
    Map<String, int> totalValues = {'impression': 0, 'clicks': 0, 'apply': 0};

    try {
      final doc = await docRef.get();
      if (doc.exists && doc.data() != null && doc.data()!['insight'] != null) {
        final insightJsonString = doc.data()!['insight'];
        Map<String, dynamic> insightData = {};

        if (insightJsonString is String) {
          insightData = jsonDecode(insightJsonString) as Map<String, dynamic>;
        } else if (insightJsonString is Map) {
          insightData = Map<String, dynamic>.from(insightJsonString);
        }

        totalValues['impression'] = _calculateTotal(insightData['impression']);
        totalValues['clicks'] = _calculateTotal(insightData['clicks']);
        totalValues['apply'] = _calculateTotal(insightData['apply']);
      }
    } catch (e) {
      print("Failed to get total values: $e");
    }

    return totalValues;
  }

  int _calculateTotal(Map<String, dynamic>? data) {
    if (data == null) return 0;

    int total = 0;
    data.forEach((month, days) {
      if (days is Map<String, dynamic>) {
        days.forEach((day, value) {
          if (value is Map<String, dynamic> && value['value'] != null) {
            total += int.tryParse(value['value']) ?? 0;
          }
        });
      }
    });
    return total;
  }

  List<Map<String, dynamic>> getLast7DaysClicksData(
      Map<String, dynamic> postInsightData) {
    List<Map<String, dynamic>> last7DaysClicks = [];
    DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime date = now.subtract(Duration(days: i));
      String month = date.month.toString();
      String day = date.day.toString();

      if (postInsightData['clicks'] != null &&
          postInsightData['clicks'][month] != null &&
          postInsightData['clicks'][month][day] != null) {
        last7DaysClicks.add({
          'date': date,
          'value': int.parse(postInsightData['clicks'][month][day]['value']),
        });
      } else {
        last7DaysClicks.add({
          'date': date,
          'value': 0,
        });
      }
    }

    return last7DaysClicks;
  }
}
