import 'package:flutter/material.dart';
import '../../../../core/app_export.dart'; // ignore: must_be_immutable

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 28.h,
        vertical: 17.v,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.v),
          CustomImageView(
            imagePath: ImageConstant.imgMdiShopOutline,
            height: 40.adaptSize,
            width: 40.adaptSize,
          ),
          SizedBox(height: 10.v),
          Text(
            "Retail Assistant",
            style: theme.textTheme.labelLarge,
          )
        ],
      ),
    );
  }
}
