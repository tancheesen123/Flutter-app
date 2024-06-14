import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewHierarchyController extends GetxController {
  static ViewHierarchyController instance = Get.find();
  DateTime? lastEmailSentTime;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var candidates = <Map<String, dynamic>>[].obs;
  var email = ''.obs;
  var deviceToken = ''.obs;

  Future<List> getAllData() async {
    final jobPostsFuture = getAllJobPost();
    final companyFuture = getCompany();
    // Add other futures here
    // final otherFuture = getOtherData();

    // Return a list of futures
    return await Future.wait([jobPostsFuture, companyFuture /*, otherFuture*/]);
  }

  Future<void> updatePostStatus(String postId, String status) async {
    DocumentReference jobPostRef =
        FirebaseFirestore.instance.collection("jobPost").doc(postId);

    await jobPostRef.update({
      "postStatus": status,
    });
  }

  Future<Map<String, List<DocumentSnapshot>>> getAllJobPost() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? companyID =
        jsonDecode(prefs.getString("companyDetail")!)["id"];

    DocumentReference companyRef =
        FirebaseFirestore.instance.collection("company").doc(companyID);

    // Fetch job posts
    QuerySnapshot jobPostSnapshot = await FirebaseFirestore.instance
        .collection("jobPost")
        .where("company", isEqualTo: companyRef)
        .get();

    // Initialize lists to store job posts and candidate details
    List<DocumentSnapshot> jobPostDocs = [];
    List<DocumentSnapshot> candidateDocs = [];

    // Logging and collecting job post data
    for (var doc in jobPostSnapshot.docs) {
      print("post id ${doc.id}");
      jobPostDocs.add(doc);

      // Fetch candidates for each job post
      QuerySnapshot candidateSnapshot = await FirebaseFirestore.instance
          .collection("jobPost")
          .doc(doc.id)
          .collection("candidate")
          .get();

      // Add all candidate documents to the list
      candidateDocs.addAll(candidateSnapshot.docs);
    }

    return {
      'postDetail': jobPostDocs,
      'candidateDetail': candidateDocs,
    };
  }

  Future<Map<String, dynamic>> getCompany() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? companyID =
        jsonDecode(prefs.getString("companyDetail")!)["id"];

    DocumentReference companyRef =
        FirebaseFirestore.instance.collection("company").doc(companyID);
    return await companyRef.get().then((documentSnapshot) {
      return documentSnapshot.data() as Map<String, dynamic>;
    });
  }

  Future<List<Map<String, dynamic>>> fetchApplications(String postId) async {
    try {
      // Get the collection of candidates
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("jobPost")
          .doc(postId)
          .collection("candidate")
          .get();

      // Convert each document in the snapshot to a Map and return the list of Maps
      List<Map<String, dynamic>> candidates = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return candidates;
    } catch (e) {
      print('Error fetching applications: $e');
      return [];
    }
  }
}
