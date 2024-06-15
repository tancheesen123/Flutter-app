import 'package:flutter/material.dart' hide SearchController;
import '../../../../core/app_export.dart';
import '../../../../widgets/custom_icon_button.dart'; // ignore: must_be_immutable

class InsightItemWidget extends StatelessWidget {
  const InsightItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.v),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle516,
            height: 50.adaptSize,
            width: 50.adaptSize,
            radius: BorderRadius.circular(
              15.h,
            ),
            margin: EdgeInsets.symmetric(vertical: 13.v),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 233.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 6.v,
                          bottom: 4.v,
                        ),
                        child: Text(
                          "Shopee Expasdasdadsress (SPX)",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      CustomIconButton(
                        height: 28.adaptSize,
                        width: 28.adaptSize,
                        padding: EdgeInsets.all(6.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgFavorite,
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "Application",
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 4.v),
                SizedBox(
                  width: 231.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "",
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        "Bukit Raja, Klang",
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        "12h",
                        style: theme.textTheme.labelLarge,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
