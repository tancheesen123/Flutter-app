import 'package:cached_network_image/cached_network_image.dart';
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
                  Map<String, dynamic> post = snapshot.data![index];
                  DocumentReference? userRef = post['user'] as DocumentReference?;

                  if (userRef == null) {
                    return Text('User reference is null');
                  }

                  return FutureBuilder<DocumentSnapshot>(
                    future: _homePageController.getUserDataByRef(userRef),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return _buildShimmerLoading_CompanyLogo();
                      }else if (userSnapshot.hasError) {
                        return Text('Error: ${userSnapshot.error}');
                      } else if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                        return Text('No user data found');
                      } else {
                        String? profileImageUrl = userSnapshot.data!.get('profileImageUrl');

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
                              decoration: AppDecoration.outlineErrorContainer.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25.h,
                                    backgroundImage: profileImageUrl != null
                                        ? CachedNetworkImageProvider(profileImageUrl)
                                        : AssetImage(ImageConstant.imgRectangle515) as ImageProvider<Object>,
                                  ),
                                  SizedBox(width: 20.h),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post['title'] ?? "Retail Assistant",
                                        style: CustomTextStyles.titleMediumPrimaryContainerSemiBold,
                                      ),
                                      SizedBox(height: 2.v),
                                      Text(
                                        post['status'] ?? "Part Time",
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "RM${post['budget']}/${post['workingHours']}h",
                                    style: CustomTextStyles.labelLarge12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
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
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: 5, // Set the desired number of shimmer items
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(15.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusStyle.roundedBorder20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.h, bottom: 4.v),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20.v,
                              width: 150.h,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 2.v),
                            Container(
                              height: 14.v,
                              width: 100.h,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 15.v, bottom: 16.v),
                        child: Container(
                          height: 20.v,
                          width: 80.h,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading_CompanyLogo() {
  return Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
      height: 50.v,
      width: 50.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: CircleAvatar(
          radius: 25.h,
          backgroundColor: Colors.white,
        ),
      ),
    ),
  );
}

}
