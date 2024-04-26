import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../presentation/Freelancer/app_navigation_screen.dart';
import '../presentation/Freelancer/home_container_screen/home_container_screen.dart';
import '../presentation/log_in_screen/log_in_screen.dart';
import '../presentation/Freelancer/select_job_category_screen/select_job_category_screen.dart';
import '../presentation/Freelancer/select_job_preference_screen/select_job_preference_screen.dart';
import '../presentation/Freelancer/sign_up_screen/sign_up_screen.dart';
import '../presentation/Freelancer/myjob_applications_container_screen/myjob_applications_container_screen.dart';
import '../presentation/Freelancer/profile_screen/profile_screen.dart';
import '../presentation/Freelancer/search_tab_container_screen/search_tab_container_screen.dart';
import '../presentation/Freelancer/settings_screen/settings_screen.dart'; // ignore_for_file: must_be_immutable

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

  static const String searchPage = '/search_page';

  static const String searchTabContainerScreen = '/search_tab_container_screen';

  static const String settingsScreen = '/settings_screen';

  static const String profileScreen = '/profile_screen';

  static const String myjobApplicationsContainerScreen =
      '/myjob_applications_container_screen';

  static const String myjobApplicationsPage = '/myjob_applications_page';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    logInScreen: (context) => LogInScreen(),
    signUpScreen: (context) => SignUpScreen(),
    selectJobCategoryScreen: (context) => SelectJobCategoryScreen(),
    selectJobPreferenceScreen: (context) => SelectJobPreferenceScreen(),
    homeContainerScreen: (context) => HomeContainerScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    searchTabContainerScreen: (context) => SearchTabContainerScreen(),
    settingsScreen: (context) => SettingsScreen(),
    profileScreen: (context) => ProfileScreen(),
    myjobApplicationsContainerScreen: (context) => MyjobApplicationsContainerScreen(),
    initialRoute: (context) => LogInScreen()
  };
}
