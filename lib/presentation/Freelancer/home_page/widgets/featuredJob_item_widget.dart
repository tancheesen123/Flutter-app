import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../applyjob/apply_job_page.dart';
import 'package:workwise/Controller/HomePageController.dart';

class FeaturedJobItemWidget extends StatefulWidget {
  const FeaturedJobItemWidget({Key? key}) : super(key: key);

  @override
  State<FeaturedJobItemWidget> createState() => _FeaturedJobItemWidgetState();
}

class _FeaturedJobItemWidgetState extends State<FeaturedJobItemWidget> {
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
          // Extract all user reference futures
          List<Future<DocumentSnapshot>> userFutures = [];
          snapshot.data!.forEach((data) {
            DocumentReference? userRef = data['user'] as DocumentReference?;
            if (userRef != null) {
              userFutures.add(_homePageController.getUserDataByRef(userRef));
            }
          });

          // Check if there are no users to load
          if (userFutures.isEmpty) {
            return Center(child: Text('No user data found'));
          }

          // Combine all futures using Future.wait
          return FutureBuilder<List<DocumentSnapshot>>(
            future: Future.wait(userFutures),
            builder: (context, userSnapshots) {
              if (userSnapshots.connectionState == ConnectionState.waiting) {
                return _buildShimmerLoading();
              } else if (userSnapshots.hasError) {
                return Text('Error: ${userSnapshots.error}');
              } else {
                return SizedBox(
                  width: 370.h,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 20.h),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 20.h,
                      );
                    },
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = snapshot.data![index];
                      DocumentSnapshot userSnapshot = userSnapshots.data![index];

                      String? profileImageUrl = userSnapshot.get('profileImageUrl');
                      String? companyName = data['companyName'];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ApplyJobScreen(postId: data['postId']);
                              },
                            ),
                          );
                        },
                        child: SizedBox(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.all(10.h),
                              decoration: AppDecoration.outlineBlack900.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20.h,
                                        backgroundImage: profileImageUrl != null
                                            ? CachedNetworkImageProvider(profileImageUrl)
                                            : AssetImage(ImageConstant.imgRectangle382) as ImageProvider<Object>,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 157.h,
                                          top: 5.v,
                                          bottom: 7.v,
                                        ),
                                        child: CustomIconButton(
                                          height: 28.adaptSize,
                                          width: 28.adaptSize,
                                          padding: EdgeInsets.all(6.h),
                                          child: CustomImageView(
                                            imagePath: ImageConstant.imgFavorite,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 3.v),
                                  Text(
                                    "$companyName",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  SizedBox(height: 11.v),
                                  Text(
                                    "${data['title']}",
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  SizedBox(height: 8.v),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 1.v),
                                        child: Text(
                                          "RM${data['budget']}/${data['workinghours']}",
                                          style: CustomTextStyles.labelLargeGray900,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 60.h),
                                        child: Text(
                                          "${data['location']}",
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5.v)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
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
