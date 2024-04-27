import 'package:flutter/material.dart';
import '../../../../core/app_export.dart'; // ignore: must_be_immutable

class ViewhierarchyItemWidget extends StatelessWidget {
  const ViewhierarchyItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 16.v,
      ),
      decoration: AppDecoration.outlineErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Warehouse Crew",
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 4.v),
                Text(
                  "Bukit Raja, Klang",
                  style: theme.textTheme.bodySmall,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 17.v,
              bottom: 11.v,
            ),
            child: Text(
              "Completed",
              style: CustomTextStyles.labelLargeGreenA700,
            ),
          )
        ],
      ),
    );
  }
}
