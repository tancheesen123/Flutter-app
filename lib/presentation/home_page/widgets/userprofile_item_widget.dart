import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart'; // ignore: must_be_immutable

class UserprofileItemWidget extends StatelessWidget {
  const UserprofileItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260.h,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(15.h),
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
                  Container(
                    height: 40.adaptSize,
                    width: 40.adaptSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        13.h,
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          ImageConstant.imgRectangle515,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
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
                "Chagee MY",
                style: theme.textTheme.bodySmall,
              ),
              SizedBox(height: 11.v),
              Text(
                "Tea Barista",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 8.v),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.v),
                    child: Text(
                      "RM72/8h",
                      style: CustomTextStyles.labelLargeGray900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 60.h),
                    child: Text(
                      "Intermark Mall, KL",
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
    );
  }
}
