import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/userprofile_item_widget.dart';
import 'package:workwise/Controller/MyJobController.dart';
import 'package:workwise/Controller/UserController.dart';
// ignore_for_file: must_be_immutable

class MyjobApplicationsPage extends StatefulWidget {
  const MyjobApplicationsPage({Key? key}) : super(key: key);

  @override
  State<MyjobApplicationsPage> createState() => _MyjobApplicationsPageState();
}

class _MyjobApplicationsPageState extends State<MyjobApplicationsPage> {
  final MyJobController myJobController = Get.put(MyJobController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: myJobController
              .fetchData(), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmer(context);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Use the data returned by the future
              List<Map<String, dynamic>> dataList = snapshot.data ?? [];
              print("this is dataList $dataList");
              return Padding(
                padding: EdgeInsets.only(top: 4.v),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 26.v,
                    );
                  },
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return UserprofileItemWidget(data: dataList[index]);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 16.v,
          bottom: 18.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Applications",
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  Widget buildShimmer(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v), // Adjust spacing between each card
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 150.h, // Adjust the height of the shimmer loading item
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 18.v),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50.h,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120.h,
                              height: 10.v,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 1.v),
                            Container(
                              width: 150.h,
                              height: 10.v,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 1.v),
                            Container(
                              width: 100.h,
                              height: 10.v,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 20.h,
                        height: 20.v,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.h),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100.h,
                        height: 30.v,
                        color: Colors.grey[300],
                      ),
                      Container(
                        width: 150.h,
                        height: 30.v,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
