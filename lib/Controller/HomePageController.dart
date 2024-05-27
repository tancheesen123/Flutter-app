import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomePageController extends GetxController {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  late StreamSubscription<DocumentSnapshot> _userDataSubscription;

  HomePageController({
    required this.firestore,
    required this.firebaseAuth,
  });

  var username = ''.obs;
  var profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      final userEmail = firebaseAuth.currentUser?.email;
      if (userEmail != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
            .collection('user')
            .doc(userEmail)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic>? userData = snapshot.data();
          username.value = userData?['username'] ?? '';
          profileImageUrl.value = userData?['profileImageUrl'] ?? '';
          
          // Set up real-time listener for user data changes
          _userDataSubscription = firestore
              .collection('user')
              .doc(userEmail)
              .snapshots()
              .listen((snapshot) {
            if (snapshot.exists) {
              Map<String, dynamic>? userData = snapshot.data();
              username.value = userData?['username'] ?? '';
              profileImageUrl.value = userData?['profileImageUrl'] ?? '';
            }
          });
        }
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Cancel the subscription when the controller is closed
    _userDataSubscription.cancel();
  }
}
