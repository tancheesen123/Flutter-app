import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import 'widgets/description_item.dart'; // ignore_for_file: must_be_immutable

class descriptionMenuPage extends StatefulWidget {
  const descriptionMenuPage({Key? key})
      : super(
          key: key,
        );

  @override
  descriptionMenuPageState createState() => descriptionMenuPageState();
}

class descriptionMenuPageState extends State<descriptionMenuPage>
    with AutomaticKeepAliveClientMixin<descriptionMenuPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillGray,
          child: Column(
            children: [SizedBox(height: 35.v), _buildOrderdetails(context)],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildOrderdetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20.v,
          );
        },
        itemCount: 1,
        itemBuilder: (context, index) {
          return DescriptionItemWidget();
        },
      ),
    );
  }
}
