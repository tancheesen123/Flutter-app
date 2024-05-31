import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  DateTime? lastEmailSentTime;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var candidates = <Map<String, dynamic>>[].obs;
  var email = ''.obs;

  Future<Map<String, dynamic>?> getUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    final docRef = FirebaseFirestore.instance.collection('user').doc(userEmail);
    final doc = await docRef.get();

    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  String getEmail() {
    return email.value;
  }
}
