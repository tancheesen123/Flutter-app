import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePageController extends GetxController {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  late StreamSubscription<DocumentSnapshot> _userDataSubscription;
  late StreamSubscription<User?> _authSubscription;

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

    // Listen to authentication state changes
    _authSubscription = firebaseAuth.authStateChanges().listen((user) {
      if (user == null) {
        // User logged out
        clearUserData();
      } else {
        // User logged in
        getUserData();
      }
    });
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

          // Prefetch the profile image
          if (profileImageUrl.value.isNotEmpty) {
            CachedNetworkImageProvider(profileImageUrl.value).resolve(ImageConfiguration());
          }
          
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

              // Prefetch the updated profile image
              if (profileImageUrl.value.isNotEmpty) {
                CachedNetworkImageProvider(profileImageUrl.value).resolve(ImageConfiguration());
              }
            }
          });
        }
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  void clearUserData() {
    username.value = '';
    profileImageUrl.value = '';
    _userDataSubscription.cancel();
  }

  @override
  void onClose() {
    super.onClose();
    // Cancel the subscriptions when the controller is closed
    _userDataSubscription.cancel();
    _authSubscription.cancel();
  }
}
