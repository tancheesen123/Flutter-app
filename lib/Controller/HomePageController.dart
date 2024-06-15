import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwise/Controller/PostInsightController.dart';
import 'package:workwise/Controller/UserController.dart';

class HomePageController extends GetxController {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  late StreamSubscription<DocumentSnapshot> _userDataSubscription;
  late StreamSubscription<User?> _authSubscription;

  final UserController userController = Get.put(UserController());

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

  Future<List<Map<String, dynamic>>> fetchJobPostData() async {
    final PostInsightController postInsightController =
        Get.put(PostInsightController());
    List<Map<String, dynamic>> dataList = [];
    var querySnapshot = await firestore
        .collection('jobPost')
        .where("postStatus", isEqualTo: "OPEN")
        .get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['postId'] = doc.id;
      dataList.add(data);
      // postInsightController.saveImpression(doc.id);

      DocumentReference? companyRef = data['company'] as DocumentReference?;
      if (companyRef != null) {
        DocumentSnapshot companySnapshot = await getCompanyData(companyRef);
        if (companySnapshot.exists) {
          data['companyName'] = companySnapshot.get('name');
        }
      }
    }
    return dataList;
  }

  Future<DocumentSnapshot> getCompanyData(DocumentReference companyRef) async {
    try {
      // Fetch the company document snapshot
      DocumentSnapshot companySnapshot = await companyRef.get();
      return companySnapshot;
    } catch (e) {
      print('Error fetching company document: $e');
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUserDataById(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await firestore.collection('user').doc(userId).get();
      return userSnapshot;
    } catch (e) {
      print('Error fetching user document: $e');
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUserDataByRef(DocumentReference userRef) async {
    try {
      DocumentSnapshot userSnapshot = await userRef.get();
      return userSnapshot;
    } catch (e) {
      print('Error fetching user document: $e');
      rethrow;
    }
  }

  Future<void> getUserData() async {
    try {
      final userEmail = firebaseAuth.currentUser?.email;
      if (userEmail != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await firestore.collection('user').doc(userEmail).get();

        if (snapshot.exists) {
          Map<String, dynamic>? userData = snapshot.data();
          username.value = userData?['username'] ?? '';
          profileImageUrl.value = userData?['profileImageUrl'] ?? '';

          // Prefetch the profile image
          if (profileImageUrl.value.isNotEmpty) {
            CachedNetworkImageProvider(profileImageUrl.value)
                .resolve(ImageConfiguration());
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
                CachedNetworkImageProvider(profileImageUrl.value)
                    .resolve(ImageConfiguration());
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
