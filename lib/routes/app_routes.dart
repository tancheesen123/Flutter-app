import 'package:flutter/material.dart';
import 'package:workwise/presentation/Client/success_post_client_screen/success_post_client_screen.dart';
import 'package:workwise/presentation/Freelancer/new_settings/settings_container_screen/settings_container_screen.dart';
import 'package:workwise/presentation/Freelancer/forgot_password_one_screen/forgot_password_one_screen.dart';
import 'package:workwise/presentation/Freelancer/forgot_password_two_screen/forgot_password_two_screen.dart';
import 'package:workwise/presentation/Freelancer/home_page/home_page.dart';
import '../core/app_export.dart';
import '../presentation/Freelancer/home_page/home_container_screen.dart';
import '../presentation/Freelancer/applyjob/apply_job_page.dart';
import '../presentation/log_in_screen/log_in_screen.dart';
import '../presentation/Freelancer/sign_up_screen/sign_up_screen.dart';
import '../presentation/Freelancer/myjob_applications_container_screen/myjob_applications_container_screen.dart';
import '../presentation/Freelancer/profile_screen/profile_screen.dart';
import '../presentation/Freelancer/search_tab_container_screen/search_tab_container_screen.dart';
import '../presentation/Freelancer/settings_screen/settings_screen.dart';
import '../presentation/Freelancer/change_password_screen/change_password_screen.dart';
import '../presentation/Freelancer/sign_up_verification_screen/sign_up_verification_screen.dart';
import '../presentation/Freelancer/check_session.dart';
import '../presentation/Client/home_client_container_screen/home_client_container_screen.dart';
import '../presentation/Client/post_list_page/post_list_page.dart';
import '../presentation/Client/NewJobPost_page/newJobPostScreen.dart';
import '../presentation/Client/home_client_page/home_client_page.dart';
import '../presentation/Freelancer/notification_screen/notification.dart';

class AppRoutes {
  //Client Routes
  static const String homeClientContainerScreen =
      '/home_client_container_screen';

  static const String homeClientPage = '/home_client_page';

  static const String postListPage = '/post_list_page';

  static const String newJobPostPage = '/NewJobPost_page';

  static const String newPostClientScreen = '/new_post_client_screen';

  static const String successPostClientScreen = '/success_post_client_screen';

  //Freelancer Routes
  static const String changePasswordScreen = '/change_password_screen';

  static const String signUpVerificationScreen = '/sign_up_verification_screen';

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

  static const String settingsContainerScreen = '/settings_container_screen';

  static const String forgotPasswordOneScreen = '/forgot_password_one_screen';

  static const String forgotPasswordTwoScreen = '/forgot_password_two_screen';

  static const String checkSession = '/check_session';

  static const String notificationScreen = '/notification_screen';
  static const String applyJobScreen = '/apply_job_page';

  static Map<String, WidgetBuilder> routes = {
    logInScreen: (context) => LogInScreen(),

    //Freelancer
    signUpScreen: (context) => SignUpScreen(),
    homeContainerScreen: (context) => HomeContainerScreen(),
    searchTabContainerScreen: (context) => SearchTabContainerScreen(),
    settingsScreen: (context) => SettingsScreen(),
    profileScreen: (context) => ProfileScreen(),
    myjobApplicationsContainerScreen: (context) =>
        MyjobApplicationsContainerScreen(),
    homePage: (context) => HomePage(),
    changePasswordScreen: (context) => ChangePasswordScreen(),
    signUpVerificationScreen: (context) => SignUpVerificationScreen(),
    settingsContainerScreen: (context) => SettingsContainerScreen(),
    forgotPasswordOneScreen: (context) => ForgotPasswordOneScreen(),
    notificationScreen: (context) => NotificationScreen(),
    //Scrum 16 - Forgot Password: Pass email arguments from screen one to screen two for resend purpose
    forgotPasswordTwoScreen: (context) {
      final email = ModalRoute.of(context)?.settings.arguments as String?;
      return ForgotPasswordTwoScreen(email: email ?? '');
    },
    checkSession: (context) => CheckSession(),
    applyJobScreen: (context) => ApplyJobScreen(),

    //Client
    homeClientContainerScreen: (context) => HomeClientContainerScreen(),
    postListPage: (context) => PostListScreen(),
    newJobPostPage: (context) => newJobPostScreen(),
    homeClientPage: (context) => HomeClientPage(),
    successPostClientScreen: (context) => SuccessPostClientScreen(),

    initialRoute: (context) => CheckSession()
    // initialRoute: (context) => ApplyJobScreen()
  };
}
