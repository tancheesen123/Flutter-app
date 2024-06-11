import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workwise/presentation/Client/post_list_page/post_list_page.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../home_client_page/home_client_page.dart';
import '../../Freelancer/notification_screen/notification.dart';
import '../../Freelancer/settings_screen/settings_screen.dart';

class HomeClientContainerScreen extends StatefulWidget {
  HomeClientContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<HomeClientContainerScreen> createState() => _HomeClientContainerScreenState();
}

class _HomeClientContainerScreenState extends State<HomeClientContainerScreen> {
  Widget currentScreen = HomeClientPage();
  int currentNavBarIndex = 0;

  void setScreen(Widget screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  void setNavBarIndex(int index) {
    setState(() {
      currentNavBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: currentScreen,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          currentIndex: currentNavBarIndex,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: SvgPicture.asset(
                ImageConstant.imgNavHome,
                colorFilter: ColorFilter.mode(Color(0xffA8A8AA), BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                ImageConstant.imgNavHome,
                colorFilter: ColorFilter.mode(Color(0xff007BFF), BlendMode.srcIn),
              ),
            ),
            BottomNavigationBarItem(
              label: "Notifications",
              icon: SvgPicture.asset(
                ImageConstant.imgHome,
                colorFilter: ColorFilter.mode(Color(0xffA8A8AA), BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                ImageConstant.imgHome,
                colorFilter: ColorFilter.mode(Color(0xff007BFF), BlendMode.srcIn),
              ),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: SvgPicture.asset(
                ImageConstant.imgNavSettings,
                colorFilter: ColorFilter.mode(Color(0xffA8A8AA), BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                ImageConstant.imgNavSettings,
                colorFilter: ColorFilter.mode(Color(0xff007BFF), BlendMode.srcIn),
              ),
            ),
          ],
          onTap: (value) {
            switch (value) {
              case 0:
                setScreen(HomeClientPage());
                setNavBarIndex(value);
                break;
              case 1:
                setScreen(PostListScreen());
                setNavBarIndex(value);
                break;
              case 2:
                setScreen(NotificationScreen());
                setNavBarIndex(value);
                break;
              case 3:
                setScreen(SettingsScreen());
                setNavBarIndex(value);
                break;
              default:
            }
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(context, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeContainerScreen;
      // Remove the case for BottomBarEnum.Messages
      // case BottomBarEnum.Jobs:
      //   return AppRoutes.postListPage;
      case BottomBarEnum.Notifications:
        return AppRoutes.notificationScreen;
      case BottomBarEnum.Settings:
        return AppRoutes.settingsScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeClientPage:
        return HomeClientPage();
      default:
        return DefaultWidget();
    }
  }
}
