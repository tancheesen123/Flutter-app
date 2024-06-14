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

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(email)
          .collection("Application")
          .get();

      // Use Future.forEach to handle asynchronous operations correctly
      await Future.forEach(querySnapshot.docs, (DocumentSnapshot doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        DocumentReference postRefPath = data['postRefPath'];
        DocumentSnapshot postDoc = await getPostData(postRefPath);

        if (postDoc.exists) {
          Map<String, dynamic> postData =
              postDoc.data() as Map<String, dynamic>;
          print("this is status ${postData['status']}");
          dataList.add({
            'statusApplication': data['status'],
            'status': postData['status'],
            'description': postData['description'],
            'location': postData['location'],
            'postId': postDoc.id,
            'title': postData['title'],
            'workingHours': postData['workingHours'],
            'budget': postData['budget'],
          });
        } else {
          print(
              'Post document does not exist for reference: ${postRefPath.path}');
        }
      });

      return dataList;
    } catch (e) {
      print('Error fetching application data: $e');
      return []; // Return an empty list or handle error as needed
    }
  }

  Future<DocumentSnapshot> getPostData(DocumentReference postRef) async {
    try {
      // Fetch the post document snapshot
      DocumentSnapshot postSnapshot = await postRef.get();
      return postSnapshot;
    } catch (e) {
      print('Error fetching post document: $e');
      rethrow; // Rethrow the error to handle it further up the call stack
    }
  }
}
