import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/app_export.dart';
import '../../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart'; // ignore_for_file: must_be_immutable

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _isSigning = false;
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = true;

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
                      textStyle: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 24.v),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: "Password",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
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
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 20.v, 20.h, 20.v),
                          child: CustomImageView(
                            imagePath: _isPasswordVisible
                                ? ImageConstant.imgUnion // Icon for visible password
                                : ImageConstant.imgUnion, // Icon for hidden password
                            height: 13.v,
                            width: 16.h,
                          ),
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 54.v,
                      ),
                      obscureText: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15.v),
                      textStyle: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 8.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget Password?",
                        style: theme.textTheme.bodySmall,
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
                            onTap:() => _signInWithGoogle(),
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

  void _signIn(BuildContext context) async {

    setState(() {
      _isSigning = true;
    });
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _firebaseAuthService.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      print("User sign in successfully");
      Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
    } else {
      print("User sign in failed");
    }
  }

  _signInWithGoogle()async{
    
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try{
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if(googleSignInAccount != null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);
        User? user = userCredential.user;
        if(user != null){
          print("User sign in successfully");
          Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
        }else{
          print("User sign in failed");
        }
      }
    }catch(e){
      print("Error: ${e.toString()}");
    }
  }
}
