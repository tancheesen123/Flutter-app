import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? emailErrorMessage;
  String? passwordErrorMessage;

  bool _isPasswordVisible = false;

  Map<String, dynamic>? _userData;
  String welcome = "Facebook";

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
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
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 17.v,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.h),
                        child: Text(
                          "Register Account",
                          style: CustomTextStyles.headlineLargeSemiBold,
                        ),
                      ),
                    ),
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
                    _buildUserName(context),
                    SizedBox(height: 24.v),
                    _buildEmail(context),
                    SizedBox(
                        height:
                            8), // Spacing between text field and error message
                    // Display error message if exists
                    if (emailErrorMessage != null)
                      Text(
                        emailErrorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 24.v),
                    _buildPassword(context),
                    SizedBox(height: 40.v),
                    _buildSignUp(context),
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
                    SizedBox(height: 45.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already Have Account? ",
                            style: theme.textTheme.bodyLarge,
                          ),
                          TextSpan(
                            text: "Log In",
                            style:
                                CustomTextStyles.titleMediumPrimaryContainer_1,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                navigateToLogin(context);
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

  Widget _buildUserName(BuildContext context) {
    return CustomTextFormField(
      controller: userNameController,
      hintText: "User Name",
      prefix: Container(
        margin: EdgeInsets.fromLTRB(20.h, 13.v, 15.h, 13.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgLock,
          height: 22.v,
          width: 20.h,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 54.v,
      ),
      textStyle: TextStyle(color: Colors.black),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      hintText: "Email Address",
      textInputType: TextInputType.emailAddress,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(20.h, 17.v, 15.h, 17.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgMessage,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 54.v,
      ),
      // Set the border directly within the CustomTextFormField
      borderDecoration: emailErrorMessage != null
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.red),
            )
          : null,
      onChanged: (value) {
        setState(() {
          emailErrorMessage = null; // Clear error message when text changes
        });
      },
      textStyle: TextStyle(color: Colors.black),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: passwordController,
          hintText: "Password",
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          obscureText: !_isPasswordVisible,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(20.h, 12.v, 15.h, 16.v),
            child: CustomImageView(
              imagePath: ImageConstant.imgLocationGray700,
              height: 26.v,
              width: 20.h,
            ),
          ),
          prefixConstraints: BoxConstraints(
            maxHeight: 54.v,
          ),
          suffix: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey, // Explicitly use the default icon color
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          suffixConstraints: BoxConstraints(
            maxHeight: 54.v,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15.v),
          textStyle: TextStyle(color: Colors.black),
          borderDecoration: passwordErrorMessage != null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.red),
                )
              : null,
          onChanged: (value) {
            setState(() {
              passwordErrorMessage =
                  null; // Clear error message when text changes
            });
          },
        ),
        // Error Message Text Widget
        if (passwordErrorMessage != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              passwordErrorMessage!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.0,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return CustomElevatedButton(
      text: "SIGN UP",
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer,
      onPressed: () {
        _signUp(context);
      },
    );
  }

  navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.logInScreen);
  }

  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  onTapTxtAlreadyhaveaccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.logInScreen);
  }

  void _signUp(BuildContext context) async {
    String username = userNameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // Regular expression patterns for password validation
    RegExp lowercaseRegex = RegExp(r'(?=.*[a-z])');
    RegExp uppercaseRegex = RegExp(r'(?=.*[A-Z])');
    RegExp digitRegex = RegExp(r'(?=.*\d)');
    RegExp lengthRegex = RegExp(r'^.{8,}$');

    // Regular expression pattern for email validation
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Check both email and password validations
    bool isEmailValid = emailRegex.hasMatch(email);
    bool isPasswordValid = lowercaseRegex.hasMatch(password) &&
        uppercaseRegex.hasMatch(password) &&
        digitRegex.hasMatch(password) &&
        lengthRegex.hasMatch(password);

    // Set error messages accordingly
    setState(() {
      emailErrorMessage = isEmailValid ? null : "Please enter a valid email";
      passwordErrorMessage = isPasswordValid
          ? null
          : "Password must contain at least 8 characters, including uppercase, lowercase, and numbers";
    });

    // If both email and password are valid, proceed with sign up
    if (isEmailValid && isPasswordValid) {
      User? user = await _firebaseAuthService.signUpWithEmailAndPassword(
          email, password);

      if (user != null) {
        print("User created successfully");
        addPersonalData(username, email, 1);
        Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
      } else {
        print("User creation failed");
      }
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

  Future<void> addPersonalData(
      String username, String email, int roleType) async {
    // if (!_loggedIn) {
    //   throw Exception('Must be logged in');
    // }

    // String customDocumentId = 'unique_id_here';
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('user').doc(username);

    await documentReference.set({
      'username': username,
      'email': email,
      'dateOfBirth': "1-1-2024",
      'gender': "male",
      'IdentityNum': 0102302103213,
      'roleType': roleType,
      'Nationality': "Malaysia",
      'Token': "123456",
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      // 'name': FirebaseAuth.instance.currentUser!.displayName,
      // 'userId': FirebaseAuth.instance.currentUser!.uid,
    });

    // return FirebaseFirestore.instance.collection('user').add(<String, dynamic>{
    //   'username': username,
    //   'email': email,
    //   'dateOfBirth': "1-1-2024",
    //   'gender': "male",
    //   'IdentityNum': 0102302103213,
    //   'roleType': roleType,
    //   'Nationality': "Malaysia",
    //   'Token': "123456",
    //   'timestamp': DateTime.now().millisecondsSinceEpoch,
    //   // 'name': FirebaseAuth.instance.currentUser!.displayName,
    //   // 'userId': FirebaseAuth.instance.currentUser!.uid,
    // });
  }
}
