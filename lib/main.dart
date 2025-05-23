import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:workwise/Controller/FirebaseApiController.dart';
import 'core/app_export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
final FirebaseApiController firebaseApiController = Get.put(FirebaseApiController());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ThemeHelper().changeTheme('primary');
  WidgetsFlutterBinding.ensureInitialized();
  
  await firebaseApiController.initNotification();

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
