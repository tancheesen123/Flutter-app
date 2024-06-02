import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/app_export.dart';
import 'widgets/viewhierarchy_item_widget.dart';
import 'package:workwise/Controller/HomePageController.dart';

class HomeClientPage extends StatefulWidget {
  const HomeClientPage({Key? key}) : super(key: key);

  @override
  State<HomeClientPage> createState() => _HomeClientPageState();
}

class _HomeClientPageState extends State<HomeClientPage> {
  final HomePageController _homePageController = Get.put(HomePageController(
    firestore: FirebaseFirestore.instance,
    firebaseAuth: FirebaseAuth.instance,
  ));

  @override
  void initState() {
    super.initState();
    _homePageController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillGray,
          child: Column(
            children: [
              SizedBox(height: 32.v),
              _buildWelcomeBack(context),
              SizedBox(height: 33.v),
              _buildYourJobPost(context),
              SizedBox(height: 17.v),
              _buildViewHierarchy(context),
              Spacer(),
              Container(
                height: 48.v,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 0),
                    end: Alignment(0, 1),
                    colors: [appTheme.gray90011, appTheme.gray40011],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeBack(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 33.h,
        right: 26.h,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoutes.clientProfileScreen);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Text(
                    "Welcome Back!",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                SizedBox(height: 2.v),
                Obx(() => RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "  ",
                          ),
                          TextSpan(
                            text: "${_homePageController.username.value} 👋",
                            style: CustomTextStyles.titleLargeOnPrimary,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    )),
              ],
            ),
            Container(
              height: 44.adaptSize,
              width: 44.adaptSize,
              margin: EdgeInsets.only(top: 7.v, bottom: 26.v),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Obx(() => _homePageController.profileImageUrl.value.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: _homePageController.profileImageUrl.value,
                        placeholder: (context, url) => Shimmer.fromColors(
                          child: Container(color: Colors.grey),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      )
                    : Shimmer.fromColors(
                        child: Container(color: Colors.grey),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                      )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYourJobPost(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 33.h,
        right: 20.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Your Job Post",
            style: CustomTextStyles.titleLargeSemiBold,
          ),
          GestureDetector(
            onTap: () {
              onTapTxtShowall(context);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 11.v),
              child: Text(
                "Show All",
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewHierarchy(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20.v,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return ViewhierarchyItemWidget();
        },
      ),
    );
  }

  onTapTxtShowall(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.postListPage);
  }
}
