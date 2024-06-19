import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
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

  Future<bool> acceptCandidate(dynamic postDetail, List listAcceptedCandidate,
      bool stopAcceptCandidate) async {
    bool success = false;
    try {
      if (stopAcceptCandidate) {
        for (var doc in listAcceptedCandidate) {
          print("this is doc's user ${doc["detail"]["user"]}");

          DocumentSnapshot userData = await getData(doc["detail"]["user"]);

          notificationController.sendNotification(
              "${userData["Token"]}",
              "Your application for ${postDetail["data"]["title"]} has been Rejected",
              "Sorry! You have been rejected for the job ${postDetail["data"]["title"]}",
              userData["email"]);
        }

        FirebaseFirestore.instance
            .collection('jobPost')
            .doc(postDetail["id"])
            .update({"postStatus": "EMPLOYED"});

        List acceptedUserRefList = [];

        listAcceptedCandidate.forEach((acceptedCandidate) {
          acceptedUserRefList.add(acceptedCandidate["detail"]["user"]);
        });

        await FirebaseFirestore.instance
            .collection('jobPost')
            .doc(postDetail["id"])
            .collection("candidate")
            .where("user", whereNotIn: acceptedUserRefList)
            .get()
            .then((value) async {
          List rejectUser = value.docs;

          await Future.forEach<dynamic>(rejectUser, (candidate) async {
            FirebaseFirestore.instance
                .collection('jobPost')
                .doc(postDetail["id"])
                .collection("candidate")
                .doc(candidate.id)
                .update({"status": "Reject"});
          });

          await Future.forEach<dynamic>(rejectUser, (candidate) async {
            dynamic userApplication = await FirebaseFirestore.instance
                .collection('user')
                .doc(candidate.id)
                .collection("Application")
                .where("postRefPath",
                    isEqualTo: postDetail["postReference"].reference)
                .get();

            await FirebaseFirestore.instance
                .collection('user')
                .doc(candidate.id)
                .collection("Application")
                .doc(userApplication.docs[0].id)
                .update({"status": "Reject"});
          });
        });
      } else {
        for (var doc in listAcceptedCandidate) {
          print("this is doc's user ${doc["detail"]["user"]}");

          DocumentSnapshot userData = await getData(doc["detail"]["user"]);
          var notification = jsonDecode(postDetail["data"]["Notification"]);

          notificationController.sendNotification(
              "${userData["Token"]}",
              "Your application for ${postDetail["data"]["title"]} has been accepted",
              "Congratulations! You have been accepted for the job ${postDetail["data"]["title"]} your Next step are:\n${notification["notification"]["body"]} ",
              userData["email"]);
        }
      }

      // await Future.forEach<dynamic>(listAcceptedCandidate, (candidate) async {
      //   FirebaseFirestore.instance
      //       .collection('jobPost')
      //       .doc(postDetail["id"])
      //       .collection("candidate")
      //       .doc(candidate["id"])
      //       .update({"status": "Accept"});
      // });

      // await Future.forEach<dynamic>(listAcceptedCandidate, (candidate) async {
      //   dynamic userApplication = await FirebaseFirestore.instance
      //       .collection('user')
      //       .doc(candidate["id"])
      //       .collection("Application")
      //       .where("postRefPath",
      //           isEqualTo: postDetail["postReference"].reference)
      //       .get();

      //   await FirebaseFirestore.instance
      //       .collection('user')
      //       .doc(candidate["id"])
      //       .collection("Application")
      //       .doc(userApplication.docs[0].id)
      //       .update({"status": "Accept"});
      // }

      // );

      success = true;
    } catch (e) {
      success = false;
    }

    return success;
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

  Future<void> getCandidateDetail(String userId) async {
    dynamic candidateDetail;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .get()
        .then((value) {
      candidateDetail = value.data();
    });

    return candidateDetail;
  }
}
