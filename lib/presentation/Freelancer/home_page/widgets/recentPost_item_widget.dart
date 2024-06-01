import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:workwise/Controller/HomePageController.dart';
import 'package:workwise/core/app_export.dart';
import 'package:workwise/presentation/Freelancer/applyjob/apply_job_page.dart'; // ignore: must_be_immutable

class RecentPostItemWidget extends StatefulWidget {
  const RecentPostItemWidget({Key? key}) : super(key: key);

  @override
  State<RecentPostItemWidget> createState() => _RecentPostItemWidgetState();
}

class _RecentPostItemWidgetState extends State<RecentPostItemWidget> {
  final HomePageController _homePageController = Get.put(HomePageController(
    firestore: FirebaseFirestore.instance,
    firebaseAuth: FirebaseAuth.instance,
  ));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _homePageController.fetchJobPostData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerLoading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SizedBox(
            width: 370.h,
            child: Padding(
              padding: EdgeInsets.only(bottom: 1.0),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      print('Post ID: ${post['postId']}');
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ApplyJobScreen(
                              postId: post['postId'],
                            );
                          },
                        ),
                      );
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.all(15.h),
                        decoration:
                            AppDecoration.outlineErrorContainer.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgRectangle515,
                              height: 50.adaptSize,
                              width: 50.adaptSize,
                              radius: BorderRadius.circular(
                                15.h,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20.h,
                                bottom: 4.v,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post['title'] ?? "Retail Assistant",
                                    style: CustomTextStyles
                                        .titleMediumPrimaryContainerSemiBold,
                                  ),
                                  SizedBox(height: 2.v),
                                  Text(
                                    post['status'] ?? "Part Time",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 15.v,
                                bottom: 16.v,
                              ),
                              child: Text(
                                "RM${post['budget']}/${post['workingHours']}h",
                                style: CustomTextStyles.labelLarge12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildShimmerLoading() {
    return SizedBox(
      width: 370.h,
      height: 150.h, // Set the height to match the actual content
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20.h),
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Adjust the number of shimmer loading items
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 250.h, // Match the width of the actual item
              height: 150.h, // Match the height of the actual item
              margin: EdgeInsets.symmetric(horizontal: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20.h), // Match the border radius
              ),
            ),
          );
        },
      ),
    );
  }
}
