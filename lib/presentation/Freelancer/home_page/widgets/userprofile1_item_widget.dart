import 'package:flutter/material.dart';
import '../../../../core/app_export.dart'; // ignore: must_be_immutable

class Userprofile1ItemWidget extends StatelessWidget {
  const Userprofile1ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.all(15.h),
        decoration: AppDecoration.outlineErrorContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRectangle516,
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
                    "Retail Assistant",
                    style: CustomTextStyles.titleMediumPrimaryContainerSemiBold,
                  ),
                  SizedBox(height: 2.v),
                  Text(
                    "Part Time",
                    style: theme.textTheme.bodySmall,
                  )
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
                "RM88/9h",
                style: CustomTextStyles.labelLarge12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
