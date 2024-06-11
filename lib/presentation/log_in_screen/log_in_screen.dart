import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workwise/presentation/Freelancer/forgot_password_one_screen/forgot_password_one_screen.dart';
import 'package:workwise/Controller/FirebaseApiController.dart';
import '../../core/app_export.dart';
import '../../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:workwise/Controller/UserController.dart'; // ignore_for_file: must_be_immutable

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  String? _emailError;
  String? _passwordError;
  String? _signInError;
  bool _isSigning = false;
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  Map<String, dynamic>? _userData;
  String welcome = "Facebook";
  final FirebaseApiController firebaseApiController =
      Get.put(FirebaseApiController());
  final UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    // Initialize controllers and form key
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // Dispose of controllers
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 20.h,
                  top: 92.v,
                  right: 20.h,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.h),
                        child: Text(
                          "Welcome Back!",
                          style: theme.textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    SizedBox(height: 3.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 212.h,
                        margin: EdgeInsets.only(left: 10.h),
                        child: Text(
                          "Fill your details or continue with social media",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            height: 1.50,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 28.v),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: "Email Address",
                      errorText: _emailError,
                      textInputType: TextInputType.emailAddress,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(20.h, 15.v, 10.h, 15.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgMessage,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 54.v,
                      ),
                      borderDecoration: _emailError != null &&
                              _passwordError !=
                                  "Email or password is incorrect. Please try again."
                          ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.red),
                            )
                          : null,
                      onChanged: (value) {
                        setState(() {
                          _emailError =
                              null; // Clear error message when text changes
                        });
                      },
                      textStyle: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 24.v),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: "Password",
                      errorText: _passwordError, // Set the error text
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: !_isPasswordVisible,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(20.h, 14.v, 14.h, 14.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgLocation,
                          height: 26.v,
                          width: 20.h,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 54.v,
                      ),
                      suffix: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors
                              .grey, // Explicitly use the default icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      borderDecoration: _passwordError != null &&
                              _passwordError !=
                                  "Email or password is incorrect. Please try again."
                          ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.red),
                            )
                          : null,
                      onChanged: (value) {
                        setState(() {
                          _passwordError =
                              null; // Clear error message when text changes
                        });
                      },
                      textStyle: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 8.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the forgot password page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordOneScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Forget Password?",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                    SizedBox(height: 35.v),
                    CustomElevatedButton(
                      text: "LOG IN",
                      buttonTextStyle:
                          CustomTextStyles.titleMediumOnErrorContainer,
                      onPressed: () {
                        _signIn(context);
                      },
                    ),
                    SizedBox(height: 35.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 12.v,
                            bottom: 9.v,
                          ),
                          child: SizedBox(
                            width: 20.h,
                            child: Divider(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            "Or Continue with",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 12.v,
                            bottom: 9.v,
                          ),
                          child: SizedBox(
                            width: 30.h,
                            child: Divider(
                              indent: 10.h,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 26.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          height: 60.adaptSize,
                          width: 60.adaptSize,
                          padding: EdgeInsets.all(13.h),
                          decoration: IconButtonStyleHelper.fillBlue,
                          child: CustomImageView(
                            imagePath: ImageConstant.img1421929991558096326,
                            onTap: () => _signInWithGoogle(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.h),
                          child: CustomIconButton(
                            height: 60.adaptSize,
                            width: 60.adaptSize,
                            padding: EdgeInsets.all(14.h),
                            decoration: IconButtonStyleHelper.fillIndigo,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgFacebook,
                              onTap: () => signInFacebook(),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 43.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "New User? ",
                            style: CustomTextStyles.titleMediumGray700,
                          ),
                          TextSpan(
                            text: "Create Account",
                            style:
                                CustomTextStyles.titleMediumPrimaryContainer_1,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                navigateToSignUp(context);
                              },
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 5.v)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  navigateToSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }

  Future<void> _signIn(BuildContext context) async {
    print("This is email intextbox ${emailController.text}");
    //Store data inside shared preference
    await storeUserEmail(emailController.text);
    if (!emailController.text.contains('@') || emailController.text.isEmpty) {
      setState(() {
        _emailError = "Please enter a valid email address";
      });
    } else {
      setState(() {
        _emailError = null;
      });
    }

    // Similar handling for password
    if (passwordController.text.isEmpty) {
      setState(() {
        _passwordError = "Password cannot be empty";
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }

    // If no errors, proceed with sign-in
    if (_emailError == null && _passwordError == null) {
      _firebaseAuthService
          .signInWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((user) async {
        if (user != null) {
          await firebaseApiController.initNotification();
          getRoleType(emailController.text.toLowerCase())
              .then((roleType) async {
            if (roleType == 1) {
              Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
            } else if (roleType == 2) {
              String uid = user.providerData[0].uid as String;
              await storeClientDetail(uid);
              Navigator.pushNamed(context, AppRoutes.homeClientContainerScreen);
            }
          }).catchError((error) {
            print("Error: $error");
            // Handle error, such as showing a dialog or displaying an error message
          });
        } else {
          setState(() {
            _passwordError =
                "Email or password is incorrect. Please try again.";
          });
        }
      }).catchError((error) {
        setState(() {
          _passwordError = "Failed to sign in. Please try again.";
        });
      });
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(authCredential);
        User? user = userCredential.user;
        if (user != null) {
          print("User sign in successfully");
          Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
        } else {
          print("User sign in failed");
        }
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  Future<int> getRoleType(String email) async {
    print("This is email intextbox $email");
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email.toLowerCase())
        .get();

    if (snapshot.docs.isNotEmpty) {
      final userData = snapshot.docs.first.data();
      final int roleType = userData['roleType'];
      // final email2 = userData[
      //     'email']; // Accessing the 'roleType' field from the document data
      // print("This is role type123: $roleType");
      // print("This is email123: $email2");
      return roleType;
    } else {
      print("No user found with email: $email");
      throw Exception("No user found with email: $email");
    }
    // notifyListeners();
  }

  Future<UserCredential> signInFacebook() async {
    final LoginResult result =
        await FacebookAuth.instance.login(permissions: ['email']);

    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
      _userData = userData;
    } else {
      print(result.message);
    }

    setState(() {
      welcome = _userData?['email'];
    });

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> storeUserEmail(String email) async {
    userController.updateEmail(email);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
  }

  Future<bool> storeClientDetail(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic clientRef =
        await FirebaseFirestore.instance.collection("user").doc(uid);

    await clientRef.get().then((DocumentSnapshot doc) async {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      await storeCompanyDetail(data["companyId"].id);

      data.remove("companyId");
      data.addAll({"uid": uid});

      String jsonClientDetail = json.encode(data);
      prefs.setString("clientDetail", jsonClientDetail);
    });
    return true;
  }

  Future<bool> storeCompanyDetail(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic companyRef =
        await FirebaseFirestore.instance.collection("company").doc(id);

    await companyRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;

      data.remove("user");
      data.addAll({"id": id});

      String jsonCompanyDetail = json.encode(data);
      prefs.setString("companyDetail", jsonCompanyDetail);
    });
    return true;
  }
}
