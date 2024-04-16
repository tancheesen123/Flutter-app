import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'widgets/jobfinderlist_item_widget.dart';

class SelectJobCategoryScreen extends StatelessWidget {
  const SelectJobCategoryScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 30.h,
            vertical: 67.v,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 28.v),
              Text(
                "Select a Job Category",
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: 22.v),
              Container(
                width: 308.h,
                margin: EdgeInsets.only(
                  left: 2.h,
                  right: 3.h,
                ),
                child: Text(
                  "Select whether you’re seeking employment opportunities or your organization requires talented individuals.",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyLarge18.copyWith(
                    height: 1.33,
                  ),
                ),
              ),
              SizedBox(height: 69.v),
              _buildJobFinderList(context),
              Spacer(),
              CustomElevatedButton(
                text: "Continue",
                margin: EdgeInsets.symmetric(horizontal: 27.h),
                buttonTextStyle: CustomTextStyles.titleMediumGray50,
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildJobFinderList(BuildContext context) {
    return SizedBox(
      height: 227.v,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 19.h,
          );
        },
        itemCount: 2,
        itemBuilder: (context, index) {
          return JobfinderlistItemWidget();
        },
      ),
    );
  }
}
