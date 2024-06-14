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

  Future getAllJobPost() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? companyID =
        jsonDecode(prefs.getString("companyDetail")!)["id"];

    DocumentReference companyRef =
        FirebaseFirestore.instance.collection("company").doc(companyID);
    return await FirebaseFirestore.instance
        .collection("jobPost")
        .where("company", isEqualTo: companyRef)
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs;
    });
  }

  Future getCompany() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? companyID =
        jsonDecode(prefs.getString("companyDetail")!)["id"];

    DocumentReference companyRef =
        FirebaseFirestore.instance.collection("company").doc(companyID);
    return await companyRef.get().then((documentSnapshot) {
      return documentSnapshot.data();
    });
  }
}
