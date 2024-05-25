import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'core/app_export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ThemeHelper().changeTheme('primary');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Check if the connection to Firebase was successful
  if (Firebase.apps.isNotEmpty) {
    print('Firebase connection established!');
  } else {
    print('Failed to connect to Firebase.');
  }
  runApp(MyApp());
}

Future<bool> checkFirebaseConnection() async {
  try {
    await FirebaseFirestore.instance.collection('dummy').doc('dummy').get();
    // If the code reaches here, the connection was successful
    return true;
  } catch (e) {
    // Connection failed
    return false;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'workwise',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
