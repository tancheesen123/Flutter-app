import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:workwise/presentation/Freelancer/notification_screen/notification.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_bottom_bar.dart';
import 'home_page.dart';
import '../profile_screen/profile_screen.dart';
import '../settings_screen/settings_screen.dart';
import '../myjob_applications_page/myjob_applications_page.dart'; // ignore_for_file: must_be_immutable
import 'package:workwise/Controller/NotificationController.dart';

// ignore_for_file: must_be_immutable
class HomeContainerScreen extends StatefulWidget {
  HomeContainerScreen({Key? key}) : super(key: key);

  @override
  _HomeContainerScreenState createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  final NotificationController notificationController =
      Get.put(NotificationController());
  GlobalKey<CustomBottomBarState> bottomBarKey =
      GlobalKey<CustomBottomBarState>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool _showNavigationBar = true; // Initial state

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.homePage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar:
            _shouldShowBottomBar(context) ? _buildBottomBar(context) : null,
      ),
    );
  }

  bool _shouldShowBottomBar(BuildContext context) {
    // Define the routes where you want the navigation bar
    final desiredRoutes = [
      AppRoutes.homeContainerScreen,
      AppRoutes.settingsScreen,
      AppRoutes.myjobApplicationsPage,
      AppRoutes.notificationScreen,
    ];
    return desiredRoutes.contains(ModalRoute.of(context)?.settings.name) &&
        _showNavigationBar;
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        print("type $type");
        final targetRoute = getCurrentRoute(type);
        _updateNavigationState(targetRoute);
        Navigator.pushNamed(
          navigatorKey.currentContext!,
          targetRoute,
        );
      },
    );
  }

  void _updateNavigationState(String targetRoute) {
    // Update _showNavigationBar based on the target route
    setState(() {
      _showNavigationBar = [
        AppRoutes.homeContainerScreen,
        AppRoutes.settingsScreen,
        AppRoutes.myjobApplicationsPage,
        AppRoutes.notificationScreen,
      ].contains(targetRoute);
    });
  }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeContainerScreen;
      case BottomBarEnum.Jobs:
        return AppRoutes.myjobApplicationsPage;
      case BottomBarEnum.Notifications:
        return AppRoutes.notificationScreen;
      case BottomBarEnum.Settings:
        return AppRoutes.settingsScreen;
      default:
        return "/";
    }
  }

  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.profileScreen:
        return ProfileScreen();
      case AppRoutes.settingsScreen:
        return SettingsScreen();
      case AppRoutes.myjobApplicationsPage:
        return MyjobApplicationsPage();
      case AppRoutes.notificationScreen:
        return NotificationScreen();
      default:
        return HomePage();
    }
  }
}
