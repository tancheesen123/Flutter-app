import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwise/Controller/UserController.dart';
import 'package:workwise/Controller/NotificationController.dart';

class ApplyJobController extends GetxController {
  static ApplyJobController instance = Get.find();
  final UserController userController = Get.put(UserController());
  final NotificationController notificationController =
      Get.put(NotificationController());

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
    final docRef = FirebaseFirestore.instance.collection('jobPost').doc(postId);
    final doc = await docRef.get();

    if (doc.exists) {
      // print(doc.data());
      return doc.data();
    } else {
      return null;
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

  // Future<void> addCandidate(
  //     String jobPostId, Map<String, dynamic> candidateData) async {
  //   String label = candidateData["label"];
  //   await _firestore
  //       .collection('jobPost')
  //       .doc(jobPostId)
  //       .collection('candidate')
  //       .doc(label) // Use the new label here
  //       .set(
  //           candidateData); // Use set instead of add to set data with specified document ID
  //   // Fetch the updated list of candidates
  //   await getCandidates(jobPostId);
  // }

  Future<bool> addCandidate2(
      String jobPostId, Map<String, dynamic> candidateData) async {
    String label = candidateData["label"];
    DocumentReference candidateRef = _firestore
        .collection('jobPost')
        .doc(jobPostId)
        .collection('candidate')
        .doc(label); // Use the new label here

    await candidateRef.set(candidateData);

    DocumentReference PostRef = _firestore
        .collection('jobPost')
        .doc(jobPostId); // Use the new label here

    String postRefPath = PostRef.path;

    // Store the reference path in another collection
    String email =
        candidateData['email']; // Assuming email is a field in candidateData
    // if (email != null && email.isNotEmpty) {
    QuerySnapshot querySnapshot = await _firestore
        .collection('user')
        .doc(email)
        .collection("Application")
        .where('postRefPath', isEqualTo: postRefPath)
        .limit(
            1) // Limit the query to 1 document, as we only need to check if any document exists
        .get();
    String token = await userController.getDeviceToken();
    notificationController.sendNotification(token);
    // notificationController.sendNotification(
    //     "eHmCoIcVRDO6ndFlCY8EGA:APA91bHkwdg1h2ADvDXAoLzM5qZSkC8DcJo6cGyw6XFo4Uqg_SdF46Aom0OZ9Tazn7Z-jG5JysoWRJpXc3036UUD53Q91BdGHoT_LZIJxH6vBBcWzf7efVGe4X_d19kCMU_36VOzhy8A");

    // if (querySnapshot.docs.isNotEmpty) {
    //   print('Document with the same postRefPath already exists');
    //   return false; // or you can throw an exception, depending on your requirements
    // } else {
    //   await _firestore
    //       .collection('user')
    //       .doc(email)
    //       .collection(
    //           "Application") // Assuming email is a valid collection name // Assuming label can be used as the document ID
    //       .add({
    //     'companyId': "a1",
    //     'postRefPath': postRefPath,
    //     'status': "pending",
    //   });
    //   // Fetch the updated list of candidates
    //   await getCandidates(jobPostId);

    //   String token = await userController.getDeviceToken();
    //   notificationController.sendNotification(token);
    // }

    // Return the reference to the added document
    return true;
  }
}
