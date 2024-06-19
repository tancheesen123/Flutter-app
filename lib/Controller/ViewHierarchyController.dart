import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
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
    final clientData = getUserInformation();

    // Add other futures here
    // final otherFuture = getOtherData();

    // Return a list of futures
    return await Future.wait(
        [jobPostsFuture, companyFuture, clientData /*, otherFuture*/]);
  }

  Future<void> updatePostStatus(String postId, String status) async {
    print("Post ID: $postId, Status: $status");
    DocumentReference jobPostRef =
        FirebaseFirestore.instance.collection("jobPost").doc(postId);

    try {
      await jobPostRef.update({
        "postStatus": status,
      });
      print("Update successful");
    } catch (e) {
      print("Failed to update post status: $e");
    }
  }

  Future<void> deletePostStatus(String postId) async {
    try {
      // Reference to the job post document
      DocumentReference jobPostRef =
          FirebaseFirestore.instance.collection("jobPost").doc(postId);

      // Check if the 'candidate' subcollection exists
      bool candidateExists = await jobPostRef
          .collection('candidate')
          .limit(1)
          .get()
          .then((querySnapshot) => querySnapshot.docs.isNotEmpty);

      if (candidateExists) {
        // Delete all documents in the 'candidate' subcollection
        QuerySnapshot candidateSnapshot =
            await jobPostRef.collection('candidate').get();
        for (var doc in candidateSnapshot.docs) {
          // Explicitly cast doc.data() to Map<String, dynamic>
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          print("User field of document ${data!['user']}");
          List<DocumentSnapshot> userDocs = await getAllApplicationData(
            data!['user'],
          );
          userDocs.forEach((userDoc) {
            // Accessing userDoc.data() assuming it's Map<String, dynamic>
            Map<String, dynamic>? userData =
                userDoc.data() as Map<String, dynamic>?;

            // Check if userData is not null to avoid runtime errors
            if (userData != null) {
              print("This is ${data['name']}'s data : ${userData}");

              // Check if 'postRefPath' exists in userData and compare with jobPostRef
              if (userData['postRefPath'] == jobPostRef) {
                print("They are the same at path $jobPostRef");
                // userDoc.reference.update({
                //   'status': 'Rejected',
                // });

                userDoc.reference.delete();
              }
            }
          });
        }
      }

      // Delete the job post document
      await jobPostRef.delete();
      print('Post deleted successfully');
    } catch (e) {
      print('Error deleting post: $e');
      throw e; // Optionally rethrow to handle error higher up in the call stack
    }
  }

  Future<List<dynamic>> getAllJobPost() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? companyID =
        jsonDecode(prefs.getString("companyDetail")!)["id"];

    DocumentReference companyRef =
        FirebaseFirestore.instance.collection("company").doc(companyID);

    // // Fetch job posts
    // QuerySnapshot jobPostSnapshot = await FirebaseFirestore.instance
    //     .collection("jobPost")
    //     .where("company", isEqualTo: companyRef)
    //     .get();

    // // Initialize lists to store job posts and candidate details
    // List<DocumentSnapshot> jobPostDocs = [];
    // List<DocumentSnapshot> candidateDocs = [];

    // // Logging and collecting job post data
    // for (var doc in jobPostSnapshot.docs) {
    //   print("post id ${doc.id}");
    //   jobPostDocs.add(doc);

    //   // Fetch candidates for each job post
    //   QuerySnapshot candidateSnapshot = await FirebaseFirestore.instance
    //       .collection("jobPost")
    //       .doc(doc.id)
    //       .collection("candidate")
    //       .get();

    //   // Add all candidate documents to the list
    //   candidateDocs.addAll(candidateSnapshot.docs);
    // }

    return await FirebaseFirestore.instance
        .collection("jobPost")
        .where("company", isEqualTo: companyRef)
        .get()
        .then((querySnapshot) async {
      List tempAllJobPostList = [];

      await Future.forEach<dynamic>(querySnapshot.docs, (job) async {
        List tempAllCandidateList = [];
        dynamic candidateList =
            await job.reference.collection("candidate").get();

        candidateList.docs.forEach((candidate) {
          tempAllCandidateList
              .add({"id": candidate.id, "detail": candidate.data()});
        });

        tempAllJobPostList.add({
          "postReference": job,
          "data": job.data(),
          "id": job.id,
          "candidate": tempAllCandidateList
        });
      });

      return tempAllJobPostList;
    });
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

  Future<List<DocumentSnapshot>> getAllApplicationData(
      DocumentReference userRef) async {
    try {
      // Fetch all documents in the "Application" collection
      QuerySnapshot querySnapshot =
          await userRef.collection("Application").get();

      // Convert QuerySnapshot to a List of DocumentSnapshot
      List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;

      return documentSnapshots;
    } catch (e) {
      print('Error fetching application documents: $e');
      rethrow; // Optionally rethrow to handle error higher up in the call stack
    }
  }

  Future<Map<String, dynamic>?> getUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    final docRef = FirebaseFirestore.instance.collection('user').doc(userEmail);
    final doc = await docRef.get();

    print("This is user information $doc");
    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }
}
