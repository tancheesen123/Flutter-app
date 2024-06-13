import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwise/Controller/UserController.dart';

class MyJobController extends GetxController {
  static MyJobController instance = Get.find();
  final UserController userController = Get.put(UserController());
  DateTime? lastEmailSentTime;

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

  Future<List<Map<String, dynamic>>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('userEmail') ?? '';

    List<Map<String, dynamic>> dataList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(email)
        .collection("Application")
        .get();

    // Use Future.forEach to handle asynchronous operations correctly
    await Future.forEach(querySnapshot.docs, (doc) async {
      Map<String, dynamic> data =
          (doc as DocumentSnapshot).data() as Map<String, dynamic>;
      String postRefPath = data['postRefPath'];
      String applicationStatus = data['status'];
      if (postRefPath != null) {
        List<String> pathParts = postRefPath.split('/');
        if (pathParts.length == 2) {
          String collection = pathParts[0];
          String documentId = pathParts[1];
          DocumentSnapshot postDoc = await FirebaseFirestore.instance
              .collection(collection)
              .doc(documentId)
              .get();

          // Check if postDoc.data() is not null before casting
          if (postDoc.data() != null) {
            Map<String, dynamic> postData =
                postDoc.data() as Map<String, dynamic>;

            postData['postId'] = doc.id;

            dataList.add({
              'statusApplication': applicationStatus,
              'status': postData['status'],
              'description': postData['description'],
              'location': postData['location'],
              'postId': documentId,
              'title': postData['title'],
              'workingHours': postData['workingHours'],
              'budget': postData['budget'],
            });
          } else {}
        }
      }
    });
    return dataList;
  }
}
