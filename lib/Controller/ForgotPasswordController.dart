import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:workwise/core/app_export.dart';
import 'package:workwise/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController instance = Get.find();
  DateTime? lastEmailSentTime;

  final email = TextEditingController();
  GlobalKey<FormState> ForgotPasswordFormKey = GlobalKey<FormState>();

  Future<bool> isEmailRegistered(String email) async {
    try {
      // Implementation to check if email is registered
      // For example, querying Firestore
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('user')
          .where("email", isEqualTo: email)
          .get();
      return query.docs.isNotEmpty;
    } catch (e) {
      print("Error checking email registration: $e");
      throw e; // Re-throw to handle in the caller
    }
  }

  sendPasswordResetEmail(BuildContext context) async {
    try {
      if (ForgotPasswordFormKey.currentState!.validate()) {
        await FirebaseAuthService().sendPasswordResetEmail(email.text.trim());
        Navigator.pushNamed(
          context,
          AppRoutes.forgotPasswordTwoScreen,
          arguments: email.text.trim(),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // Check if enough time has elapsed since the last email was sent
      if (lastEmailSentTime == null ||
          DateTime.now().difference(lastEmailSentTime!) >=
              Duration(seconds: 60)) {
        if (ForgotPasswordFormKey.currentState!.validate()) {
          await FirebaseAuthService().sendPasswordResetEmail(email);

          // Update the last email sent time
          lastEmailSentTime = DateTime.now();

          Fluttertoast.showToast(
            msg: "Reset email link has been sent to your email",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        // Inform the user that they can only resend the email after 60 seconds
        Fluttertoast.showToast(
          msg: "You can only resend the email every 60 seconds",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
      if (e is FirebaseAuthException && e.code == 'too-many-requests') {
        // Display error message to the user
        Fluttertoast.showToast(
          msg:
              "We have blocked all requests from this device due to unusual activity. Try again later.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }
}
