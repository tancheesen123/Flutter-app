import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../core/app_export.dart';
import 'package:workwise/Controller/NotificationController.dart';

enum BottomBarEnum { Home, Messages, Jobs, Notifications, Settings }

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged, Key? key}) : super(key: key);

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  final NotificationController notificationController =
      Get.put(NotificationController());
  int selectedIndex = 0;
  Future<List<Map<String, dynamic>>>? _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = notificationController.fetchActiveNotifications();
  }

  void refreshActiveNotifications() {
    setState(() {
      _notificationsFuture = notificationController.fetchActiveNotifications();
    });
  }

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavHome,
      activeIcon: ImageConstant.imgNavHome,
      title: "Home",
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgPhBagFill,
      activeIcon: ImageConstant.imgPhBagFill,
      title: "My Jobs",
      type: BottomBarEnum.Jobs,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      activeIcon: ImageConstant.imgHome,
      title: "Notifications",
      type: BottomBarEnum.Notifications,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavSettings,
      activeIcon: ImageConstant.imgNavSettings,
      title: "Settings",
      type: BottomBarEnum.Settings,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.onErrorContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(31.h),
          topRight: Radius.circular(30.h),
        ),
      ),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final notifications = snapshot.data!;
            final hasNotifications = notifications.isNotEmpty;
            final notificationLenght = notifications.length;

            return BottomNavigationBar(
              backgroundColor: Colors.transparent,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              elevation: 0,
              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              items: List.generate(bottomMenuList.length, (index) {
                if (index == 2 && hasNotifications) {
                  return BottomNavigationBarItem(
                    icon: _buildNotificationIcon(index, notificationLenght),
                    activeIcon:
                        _buildActiveNotificationIcon(index, notificationLenght),
                    label: '',
                  );
                } else {
                  return BottomNavigationBarItem(
                    icon: _buildIcon(index),
                    activeIcon: _buildActiveIcon(index),
                    label: '',
                  );
                }
              }),
              onTap: (index) {
                if (index == 2) {
                  refreshActiveNotifications();
                }
                selectedIndex = index;
                widget.onChanged?.call(bottomMenuList[index].type);
                setState(() {});
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildNotificationIcon(int index, int notificationLenght) {
    return Column(
      children: [
        Badge(
          label: Text('$notificationLenght'),
          child: CustomImageView(
            imagePath: bottomMenuList[2].icon,
            height: 18.adaptSize,
            width: 18.adaptSize,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.v),
          child: Text(
            bottomMenuList[index].title ?? "",
            style: CustomTextStyles.bodySmallOnPrimaryContainer.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveNotificationIcon(int index, int notificationLenght) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Badge(
          label: Text('$notificationLenght'),
          child: CustomImageView(
            imagePath: bottomMenuList[2].activeIcon,
            height: 18.v,
            width: 17.h,
            color: Color(0xFF007BFF),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.v),
          child: Text(
            bottomMenuList[index].title ?? "",
            style: CustomTextStyles.bodySmallOnPrimaryContainer.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: bottomMenuList[index].icon,
          height: 18.adaptSize,
          width: 18.adaptSize,
          color: theme.colorScheme.onPrimaryContainer,
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.v),
          child: Text(
            bottomMenuList[index].title ?? "",
            style: CustomTextStyles.bodySmallOnPrimaryContainer.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildActiveIcon(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: bottomMenuList[index].activeIcon,
          height: 18.v,
          width: 17.h,
          color: Color(0xFF007BFF),
        ),
        Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Text(
            bottomMenuList[index].title ?? "",
            style: CustomTextStyles.bodySmallSecondaryContainer.copyWith(
              color: Color(0xFF007BFF),
            ),
          ),
        )
      ],
    );
  }
}

class BottomMenuModel {
  BottomMenuModel(
      {required this.icon,
      required this.activeIcon,
      this.title,
      required this.type});

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
