import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:workwise/presentation/Freelancer/applyjob/apply_job_page.dart';
import '../../../../core/app_export.dart';
import 'package:workwise/Controller/ApplyJobController.dart';

class UserprofileItemWidget extends StatefulWidget {
  final Map<String, dynamic> data;

  const UserprofileItemWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<UserprofileItemWidget> createState() => _UserprofileItemWidgetState();
}

class _UserprofileItemWidgetState extends State<UserprofileItemWidget> {
  final ApplyJobController applyJobController = Get.put(ApplyJobController());
  String? profileImageUrl;
  String? companyName;

  @override
  void initState() {
    super.initState();
    fetchUserProfileImage();
    fetchCompanyName();
  }

  Future<void> fetchUserProfileImage() async {
    try {
      DocumentReference userRef = widget.data['user'] as DocumentReference;
      String? url = await applyJobController.getProfileImageUrl(userRef);
      if (url != null) {
        setState(() {
          profileImageUrl = url;
        });
      }
    } catch (e) {
      print('Error fetching user profile image: $e');
    }
  }

  Future<void> fetchCompanyName() async {
    try {
      DocumentReference companyRef = widget.data['company'] as DocumentReference;
      DocumentSnapshot companySnapshot = await applyJobController.getCompanyData(companyRef);
      
      if (companySnapshot.exists) {
        String companyname = companySnapshot.get('name'); // Replace 'name' with your actual field name
        setState(() {
          companyName = companyname;
        });
      } else {
        print('Company document does not exist');
      }
    } catch (e) {
      print('Error fetching company data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String location = widget.data['location'];
    String postId = widget.data['postId'];
    String title = widget.data['title'];
    String status = widget.data['statusApplication'];
    int workingHours = 12;
    int budget = widget.data['budget'];
    

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ApplyJobScreen(
                postId: "$postId",
              );
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 18.v,
          ),
          decoration: AppDecoration.outlineGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (profileImageUrl != null)
                    CircleAvatar(
                      radius: 25.h,
                      backgroundImage: profileImageUrl != null
                          ? CachedNetworkImageProvider(profileImageUrl!)
                          : AssetImage(ImageConstant.imgRectangle382)
                              as ImageProvider<Object>,
                    )
                  else
                    _buildShimmerLoading_CompanyLogo(),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$companyName",
                          // "$CompanyId",
                          style: theme.textTheme.bodySmall,
                        ),
                        Text(
                          "$title",
                          // "123",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 1.v),
                        Text(
                          // "$location",
                          "$location",
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomImageView(
                    imagePath: ImageConstant.imgNotification,
                    height: 18.v,
                    width: 20.h,
                    margin: EdgeInsets.only(top: 3.v, bottom: 35.v),
                  )
                ],
              ),
              SizedBox(height: 14.v),
              Padding(
                padding: EdgeInsets.only(left: 4.h, right: 7.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (status == 'Pending')
                      buildCustomPendingBtn(context)
                    else if (status == 'Reject')
                      buildCustomRejectBtn(context)
                    else
                      buildCustomAcceptBtn(context),
                    Padding(
                      padding: EdgeInsets.only(top: 4.v, bottom: 2.v),
                      child: Text(
                        "RM$budget/$workingHours hours",
                        style: CustomTextStyles.titleMediumBluegray900,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomPendingBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Color(0xFFF29339).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Pending',
            style: TextStyle(
              color: Color(0xFFF29339),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCustomAcceptBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 73, 242, 57).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Accepted',
            style: TextStyle(
              color: Color.fromARGB(255, 88, 242, 57),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCustomRejectBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Color(0xFFFF0021).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Reject',
            style: TextStyle(
              color: Color(0xFFFF0021),
              fontWeight: FontWeight.bold,
            ),
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
