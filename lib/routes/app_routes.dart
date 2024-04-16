import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/home_container_screen/home_container_screen.dart';
import '../presentation/log_in_screen/log_in_screen.dart';
import '../presentation/select_job_category_screen/select_job_category_screen.dart';
import '../presentation/select_job_preference_screen/select_job_preference_screen.dart';
import '../presentation/sign_up_screen/sign_up_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String logInScreen = '/log_in_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String selectJobCategoryScreen = '/select_job_category_screen';

  static const String selectJobPreferenceScreen =
      '/select_job_preference_screen';

  static const String homeContainerScreen = '/home_container_screen';

  static const String homePage = '/home_page';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    logInScreen: (context) => LogInScreen(),
    signUpScreen: (context) => SignUpScreen(),
    selectJobCategoryScreen: (context) => SelectJobCategoryScreen(),
    selectJobPreferenceScreen: (context) => SelectJobPreferenceScreen(),
    homeContainerScreen: (context) => HomeContainerScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => LogInScreen()
  };
}
