import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workwise/Controller/UserController.dart';

class SignUpVerificationScreen extends StatefulWidget {
  const SignUpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SignUpVerificationScreen> createState() =>
      _SignUpVerificationScreenState();
}

class _SignUpVerificationScreenState extends State<SignUpVerificationScreen> {
  bool isVerified = false;
  Timer? timer;
  bool canResendEmail = false;
  String? userEmail;

  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userEmail = FirebaseAuth.instance.currentUser?.email;
    checkVerificationStatus(userEmail);
    timer = Timer.periodic(
        const Duration(seconds: 3), (timer) => checkVerificationStatus(userEmail));
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendVerificationEmail();
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 19.h,
            vertical: 17.v,
          ),
          child: Column(
            children: [
              Text(
                "Verify Your Email",
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(height: 20.v),
              Container(
                width: 306.h,
                margin: EdgeInsets.symmetric(horizontal: 15.h),
                child: Text(
                  "An email has been send to your email for verification. Once verified, you’ ll be redirect to home page.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyLargeGray700.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 38.v),
              CustomImageView(
                imagePath: ImageConstant.imgEmail,
                height: 256.v,
                width: 278.h,
              ),
              SizedBox(height: 67.v),
              CustomElevatedButton(
                height: 54.v,
                text: "RESENT EMAIL",
                buttonStyle: CustomButtonStyles.fillSecondaryContainerTL12,
                onPressed: () {
                  if (canResendEmail) {
                    sendVerificationEmail();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text("Email can only be resent every 60 seconds"),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.fromLTRB(30.h, 17.v, 335.h, 17.v),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 60));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future checkVerificationStatus(userEmail) async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    await _userController.storeUserEmail(userEmail);
    if (isVerified) {
      timer?.cancel();
      Navigator.pushNamed(context, AppRoutes.checkSession);
    }
  }
}
