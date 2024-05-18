import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyJobController extends GetxController {
  static ApplyJobController instance = Get.find();
  DateTime? lastEmailSentTime;

  final email = TextEditingController();

  Future<String> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? "";
  }

  // Future<String> getPostDetails(String postId) async {
  //   if (postId != null) {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('jobPost')
  //         .where('postId', isEqualTo: postId)
  //         .get();

  //     if (snapshot.docs.isNotEmpty) {
  //       String title = snapshot.docs.first.get('title');
  //       String status = snapshot.docs.first.get('status');
  //       int workingHours = snapshot.docs.first.get('workingHours');
  //       String location = snapshot.docs.first.get('location');
  //       int description = snapshot.docs.first.get('description');
  //       double budget = snapshot.docs.first.get('budget');

  //       return title;
  //     }
  //   }
  //   return "Username not found"; // Return a default value
  // }

  Future<Map<String, dynamic>?> getJobPostData(String postId) async {
    final docRef = FirebaseFirestore.instance.collection('jobPost').doc(postId);
    final doc = await docRef.get();

    if (doc.exists) {
      print(doc.data());
      return doc.data();
    } else {
      return null;
    }
  }

  // if (snapshot.docs.isNotEmpty) {
  //   DocumentSnapshot document = snapshot.docs.first;
  //   JobPost jobPost = JobPost.fromSnapshot(document);
  //   print("hallo $jobPost.status");
  //   return jobPost;
  //
}
