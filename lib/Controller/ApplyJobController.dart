import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwise/Controller/UserController.dart';
import 'package:workwise/Controller/NotificationController.dart';
import 'package:workwise/Controller/PostInsightController.dart';

class ApplyJobController extends GetxController {
  static ApplyJobController instance = Get.find();
  final UserController userController = Get.put(UserController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  final PostInsightController postInsightController =
      Get.put(PostInsightController());

  DateTime? lastEmailSentTime;

  final storageRef = FirebaseStorage.instance.ref();

  final email = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var candidates = <Map<String, dynamic>>[].obs;

  Future<String> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? "";
  }

  Future<Map<String, dynamic>?> getJobPostData(String postId) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('jobPost').doc(postId);
      final doc = await docRef.get();

      if (doc.exists) {
        final data = doc.data();
        if (data == null) {
          return null; // Handle the case where data is null
        }

        DocumentReference companyRef = data['company'];
        DocumentSnapshot companyData = await getCompanyData(companyRef);

        return {
          'jobpostData': data,
          'companyData': companyData.data(),
        };
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching job post data: $e');
      return null; // Or handle the error as needed
    }
  }

  Future<void> getCandidates(String jobPostId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('jobPost')
        .doc(jobPostId)
        .collection('candidate')
        .get();

    List<DocumentSnapshot> docs = querySnapshot.docs;
    List<Map<String, dynamic>> candidatesList =
        docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    candidates.value = candidatesList;
  }

  Future<bool> addCandidate2(
      String jobPostId, Map<String, dynamic> candidateData) async {
    String label = candidateData["label"];
    DocumentReference candidateRef = _firestore
        .collection('jobPost')
        .doc(jobPostId)
        .collection('candidate')
        .doc(label);

    await candidateRef.set(candidateData);

    DocumentReference postRef = _firestore.collection('jobPost').doc(jobPostId);
    String postRefPath = postRef.path;

    // Store the reference path in another collection
    String email =
        candidateData['email']; // Assuming email is a field in candidateData
    if (email != null && email.isNotEmpty) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('user')
          .doc(email)
          .collection("Application")
          .where('postRefPath', isEqualTo: postRefPath)
          .limit(
              1) // Limit the query to 1 document, as we only need to check if any document exists
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print('Document with the same postRefPath already exists');
        return false; // or you can throw an exception, depending on your requirements
      } else {
        await _firestore
            .collection('user')
            .doc(email)
            .collection(
                "Application") // Assuming email is a valid collection name
            .add({
          'postRefPath': postRefPath,
          'status': "Pending",
        });

        // Fetch the updated list of candidates
        await getCandidates(jobPostId);

        // Fetch necessary data for notifications
        var jobPostData = await getJobPostData(jobPostId);
        print("Job Post Data: $jobPostData");
        DocumentSnapshot companyData =
            await getCompanyData(jobPostData!["jobpostData"]['company']);
        DocumentSnapshot userData = await getUserData(companyData["user"]);

        // Save apply insight and send notification
        await postInsightController.saveApply(jobPostId);
        notificationController.sendNotification(
            "${userData["Token"]}",
            "Congrats! You have a new application",
            "You have a new application for the job ${companyData["name"]}");
      }
    }

    // Return the reference to the added document
    return true;
  }

  Future<DocumentSnapshot> getCompanyData(DocumentReference companyRef) async {
    try {
      // Fetch the company document snapshot
      DocumentSnapshot companySnapshot = await companyRef.get();
      return companySnapshot;
    } catch (e) {
      print('Error fetching company document: $e');
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUserData(DocumentReference userRef) async {
    try {
      // Fetch the company document snapshot
      DocumentSnapshot userSnapshot = await userRef.get();
      return userSnapshot;
    } catch (e) {
      print('Error fetching userSnapshot document: $e');
      rethrow;
    }
  }
}
