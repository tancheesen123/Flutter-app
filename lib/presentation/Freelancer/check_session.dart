import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwise/routes/app_routes.dart';

class CheckSession extends StatefulWidget {
  const CheckSession({Key? key}) : super(key: key);

  @override
  _CheckSessionState createState() => _CheckSessionState();
}

class _CheckSessionState extends State<CheckSession> {
  bool sessionActive = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), checkSessionStatus);
  }

  Future<void> checkSessionStatus() async {
    bool isActive = await checkSession();
    setState(() {
      sessionActive = isActive;
    });
    print('Is session active? $sessionActive');
    if (sessionActive) {
      Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
    } else {
      Navigator.pushNamed(context, AppRoutes.logInScreen);
    }
  }

  // Function to check if the session is active
  Future<bool> checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    // Assuming session is active if userEmail is not null
    return userEmail != null;
  }

  @override
  Widget build(BuildContext context) {
    // You can customize the splash screen UI here
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash2.png', // Replace 'splash_image.png' with your image asset path
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CheckSession(),
  ));
}
