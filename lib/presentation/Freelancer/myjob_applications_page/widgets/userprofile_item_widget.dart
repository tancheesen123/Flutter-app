import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:workwise/presentation/Freelancer/applyjob/apply_job_page.dart';
import '../../../../core/app_export.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart'; // ignore: must_be_immutable
import 'package:workwise/Controller/UserController.dart';

class UserprofileItemWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  const UserprofileItemWidget({Key? key, required this.data})
      : super(
          key: key,
        );

  @override
  State<UserprofileItemWidget> createState() => _UserprofileItemWidgetState();
}

class _UserprofileItemWidgetState extends State<UserprofileItemWidget> {
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    // String postRefPath = data['postRefPath'];
    print("this is widget data ${widget.data['postId']}");
    String email = userController.getEmail();
    String location = widget.data['location'];
    String postId = widget.data['postId'];
    // print("Locationasd: $location");
    String title = widget.data['title'];
    String status = widget.data['statusApplication'];
    int workingHours = 12;
    int budget = widget.data['budget'];

    return GestureDetector(
      onTap: () {
        print('Post ID: $postId');

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
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle5162,
                    height: 50.adaptSize,
                    width: 50.adaptSize,
                    radius: BorderRadius.circular(
                      15.h,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 3.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "123",
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
                    margin: EdgeInsets.only(
                      top: 3.v,
                      bottom: 35.v,
                    ),
                  )
                ],
              ),
              SizedBox(height: 14.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.h,
                  right: 7.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // CustomElevatedButton(
                    //   width: 135.h,
                    //   text: "$status",
                    //   // text: "123",
                    //   buttonStyle: status == 'Pending'
                    //       ? buildCustomPendingBtn(context),
                    //       : status == 'Reject'
                    //           ? CustomButtonStyles
                    //               .fillOrangeA // Change to appropriate color for reject status
                    //           : CustomButtonStyles
                    //               .fillPrimary, // Change to appropriate color for accept status
                    //   buttonTextStyle: CustomTextStyles.titleSmallBlack900,
                    // ),
                    if (status == 'Pending')
                      buildCustomPendingBtn(context)
                    else if (status == 'Reject')
                      buildCustomRejectBtn(context)
                    else
                      buildCustomAcceptBtn(context),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 4.v,
                        bottom: 2.v,
                      ),
                      child: Text(
                        "RM$budget/$workingHours hours",
                        // "RMhours",
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
}
