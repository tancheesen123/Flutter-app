import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // ignore: must_be_immutable

class JobfinderlistItemWidget extends StatelessWidget {
  const JobfinderlistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 59.v,
      ),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      width: 147.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgPhBagFill,
            height: 38.adaptSize,
            width: 38.adaptSize,
          ),
          SizedBox(height: 9.v),
          Text(
            "Find a Job",
            style: CustomTextStyles.titleMediumPrimaryContainer,
          ),
          SizedBox(height: 6.v),
          Text(
            "I want to find a job",
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 6.v)
        ],
      ),
    );
  }
}
