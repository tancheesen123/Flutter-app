import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwise/Controller/NotificationController.dart';

class CandidateController extends GetxController {
  static CandidateController instance = Get.find();
  DateTime? lastEmailSentTime;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var candidates = <Map<String, dynamic>>[].obs;
  var email = ''.obs;
  var deviceToken = ''.obs;
  final NotificationController notificationController =
      Get.put(NotificationController());

  Future<bool> acceptCandidate(
      dynamic postDetail, List listAcceptedCandidate) async {
    try {
      // await FirebaseFirestore.instance.collection('jobPost').doc(postDetail["id"]).update({"postStatus": "EMPLOYED"});
      for (var doc in listAcceptedCandidate) {
        print("this is doc's user ${doc["detail"]["user"]}");

        DocumentSnapshot userData = await getData(doc["detail"]["user"]);

        // Perform your notification handling or any other logic here

        notificationController.sendNotification(
            "${userData["Token"]}",
            "Your application for ${postDetail["data"]["title"]} has been accepted",
            "Congratulations! You have been accepted for the job ${postDetail["data"]["title"]} your Next step are:\n${postDetail["data"]["description"]} ",
            userData["email"]);
      }

      await Future.forEach<dynamic>(listAcceptedCandidate, (candidate) async {
        FirebaseFirestore.instance
            .collection('jobPost')
            .doc(postDetail["id"])
            .collection("candidate")
            .doc(candidate["id"])
            .update({"status": "Accept"});
      });

      await Future.forEach<dynamic>(listAcceptedCandidate, (candidate) async {
        dynamic userApplication = await FirebaseFirestore.instance
            .collection('user')
            .doc(candidate["id"])
            .collection("Application")
            .where("postRefPath",
                isEqualTo: postDetail["postReference"].reference)
            .get();

        print(userApplication);
        await FirebaseFirestore.instance
            .collection('user')
            .doc(candidate["id"])
            .collection("Application")
            .doc(userApplication.docs[0].id)
            .update({"status": "Accept"});
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<DocumentSnapshot> getData(DocumentReference userRef) async {
    try {
      // Fetch the company document snapshot
      DocumentSnapshot userSnapshot = await userRef.get();
      return userSnapshot;
    } catch (e) {
      print('Error fetching userSnapshot document: $e');
      rethrow;
    }
  }

  // Future<QuerySnapshot> fetchNotificationData(dynamic userData) async {
  //   try {
  //     print("This is userData: ${userData["email"]}");

  //     QuerySnapshot notificationSnapshot = await FirebaseFirestore.instance
  //         .collection("user")
  //         .doc(userData["email"])
  //         .collection("Notification")
  //         .get();

  //     // Loop through each document in the snapshot
  //     notificationSnapshot.docs.forEach((doc) {
  //       // Access document data using doc.data()
  //       print("Document ID: ${doc.id}");
  //       print("Document Data: ${doc.data()}");
  //     });

  //     return notificationSnapshot;
  //   } catch (e) {
  //     print("Error fetching notification data: $e");
  //     throw e; // Optionally rethrow the error to handle it higher up in the call stack
  //   }
  // }
}
