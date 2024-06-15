import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageJobPostController extends GetxController {
  Future<bool> submitJobPost(String title, String location, String budget, String description, String messageTitle, String messageBody) async {
    try {
      final now = DateTime.now(); // Replace with current date in production
      final month = now.month;
      final day = now.day;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? clientUID = jsonDecode(prefs.getString("clientDetail")!)["uid"];
      final String? companyID = jsonDecode(prefs.getString("companyDetail")!)["id"];

      DocumentReference userRef = FirebaseFirestore.instance.collection("user").doc(clientUID);
      DocumentReference companyRef = FirebaseFirestore.instance.collection("company").doc(companyID);

      Map<String, dynamic> notificationData = {
        "notification": {
          "title": messageTitle,
          "body": messageBody,
        }
      };

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

      Map<String, dynamic> data = {
        "title": title,
        "location": location,
        "budget": int.parse(budget),
        "description": description,
        "insight": json.encode(insightData),
        // "status": "Part Time",
        // "workingHours": 20,
        "user": userRef,
        "company": companyRef,
        "postStatus": "OPEN",
        "Notification": json.encode(notificationData)
      };

      await FirebaseFirestore.instance.collection("jobPost").add(data).then((value) {
        return true;
      });
    } catch (e) {
      return false;
    }

    return false;
  }

  Future<bool> editJobPost(
      String postId, String title, String location, String budget, String description, String messageTitle, String messageBody) async {
    bool success = false;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? clientUID = jsonDecode(prefs.getString("clientDetail")!)["uid"];
      final String? companyID = jsonDecode(prefs.getString("companyDetail")!)["id"];

      DocumentReference userRef = FirebaseFirestore.instance.collection("user").doc(clientUID);
      DocumentReference companyRef = FirebaseFirestore.instance.collection("company").doc(companyID);

      Map<String, dynamic> notificationData = {
        "notification": {
          "title": messageTitle,
          "body": messageBody,
        }
      };

      Map<String, dynamic> data = {
        "title": title,
        "location": location,
        "budget": int.parse(budget),
        "description": description,
        "user": userRef,
        "company": companyRef,
        "Notification": json.encode(notificationData)
      };

      await FirebaseFirestore.instance.collection("jobPost").doc(postId).update(data).then((value) {
        success = true;
      });
    } catch (e) {
      success =  false;
    }

    return success;
  }
}
