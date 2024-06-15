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
  var deviceToken = ''.obs;

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

  Future<Map<String, dynamic>?> getSpecificUserInformation(
      String userEmail) async {
    final docRef = FirebaseFirestore.instance.collection('user').doc(userEmail);
    final doc = await docRef.get();

    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }

  Future<void> addToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('userEmail') ?? '';
    print(email);

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('user').doc(email.toLowerCase());

    await documentReference.update({
      'Token': token,
    });

    deviceToken.value = token;
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  String getEmail() {
    return email.value;
  }

  String getDeviceToken() {
    return deviceToken.value;
  }

  Future<void> storeUserEmail(String email) async {
    updateEmail(email);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
  }
}
