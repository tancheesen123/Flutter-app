import 'package:flutter/material.dart';
import 'package:workwise/presentation/Client/home_client_page/widgets/viewhierarchy_item_widget.dart';
import 'package:workwise/widgets/app_bar/appbar_title.dart';
import 'package:workwise/widgets/app_bar/custom_app_bar.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_text_form_field.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController duration1Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: appTheme.gray50,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillGray,
            child: Column(
              children: [
                SizedBox(height: 20.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.h),
                    child: Text(
                      "Mark All as Read",
                      style: CustomTextStyles.labelLargeGray700,
                    ),
                  ),
                ),
                SizedBox(height: 25.v),
                Container(
                  width: 321.h,
                  margin: EdgeInsets.only(
                    left: 29.h,
                    right: 24.h,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Oh No! We regret to inform you that your application for the Tea Barista position at ",
                          style: CustomTextStyles.bodyMediumOnPrimary_1.copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: "Chagee ",
                          style: CustomTextStyles.titleSmallOnPrimary.copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: "has been rejected.",
                          style: CustomTextStyles.bodyMediumOnPrimary_1.copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 4.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 29.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "10 min ago",
                          style: CustomTextStyles.labelLargeOnPrimary,
                        ),
                        Container(
                          height: 8.adaptSize,
                          width: 8.adaptSize,
                          margin: EdgeInsets.only(
                            left: 6.h,
                            top: 4.v,
                            bottom: 7.v,
                          ),
                          decoration: BoxDecoration(
                            color: appTheme.indigo600,
                            borderRadius: BorderRadius.circular(4.h),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.v),
                _buildDivider(),
                SizedBox(height: 20.v),
                Container(
                  width: 321.h,
                  margin: EdgeInsets.only(
                    left: 29.h,
                    right: 24.h,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Your application for the Warehouse Crew position at ",
                          style: CustomTextStyles.bodyMediumOnPrimary_1.copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: "SPX",
                          style: CustomTextStyles.titleSmallBlack900.copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: "  has been successfully submitted. You will be notified when the application status is updated.",
                          style: CustomTextStyles.bodyMediumOnPrimary_1.copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 4.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 29.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "4 hours ago",
                          style: CustomTextStyles.labelLargeOnPrimary,
                        ),
                        Container(
                          height: 8.adaptSize,
                          width: 8.adaptSize,
                          margin: EdgeInsets.only(
                            left: 6.h,
                            top: 4.v,
                            bottom: 7.v,
                          ),
                          decoration: BoxDecoration(
                            color: appTheme.indigo600,
                            borderRadius: BorderRadius.circular(4.h),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.v),
                _buildDivider(),
                SizedBox(height: 20.v),
                Container(
                  width: 315.h,
                  margin: EdgeInsets.only(
                    left: 29.h,
                    right: 30.h,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Your job at SPX is completed. Please make sure to get your salary from your supervisor.",
                          style: CustomTextStyles.bodyMediumGray50001.copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 7.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 29.h),
                    child: Text(
                      "1 days ago",
                      style: CustomTextStyles.labelLargeGray50001,
                    ),
                  ),
                ),
                SizedBox(height: 20.v),
                _buildDivider(),
                SizedBox(height: 20.v),
                Container(
                  width: 315.h,
                  margin: EdgeInsets.only(
                    left: 29.h,
                    right: 30.h,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Congratulations! Your application for the Warehouse Crew position at ",
                          style: CustomTextStyles.bodyMediumGray50001.copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: "SPX",
                          style: CustomTextStyles.titleSmallBlack900.copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: " has been approved. ",
                          style: CustomTextStyles.bodyMediumGray50001.copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: "Click here ",
                          style: CustomTextStyles.bodyMediumPrimary.copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: "to view the instructions. ",
                          style: CustomTextStyles.bodyMediumGray50001.copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 7.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 29.h),
                    child: Text(
                      "3 days ago",
                      style: CustomTextStyles.labelLargeGray50001,
                    ),
                  ),
                ),
                SizedBox(height: 20.v),
                _buildDivider(),
                SizedBox(height: 20.v),
                Container(
                  width: 315.h,
                  margin: EdgeInsets.only(
                    left: 29.h,
                    right: 30.h,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Your application for the Warehouse Crew position at ",
                          style: CustomTextStyles.bodyMediumGray50001.copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: "SPX",
                          style: CustomTextStyles.titleSmallBlack900.copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: "  has been successfully submitted. You will be notified when the application status is updated.",
                          style: CustomTextStyles.bodyMediumGray50001.copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 7.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 29.h),
                    child: Text(
                      "5 days ago",
                      style: CustomTextStyles.labelLargeGray50001,
                    ),
                  ),
                ),
                SizedBox(height: 30.v),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(
        text: "Notification",
      ),
    );
  }

Widget _buildDivider() {
    return Divider(
      color: appTheme.gray6007f,
      indent: 29.h,
      endIndent: 30.h,
      thickness: 0.5,
    );
  }

}
