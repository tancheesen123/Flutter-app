import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import 'widgets/company_item.dart'; // ignore_for_file: must_be_immutable
import 'widgets/post_insight_item.dart';

class CompanyMenuPage extends StatefulWidget {
  const CompanyMenuPage({Key? key})
      : super(
          key: key,
        );

  @override
  CompanyMenuPageState createState() => CompanyMenuPageState();
}

class CompanyMenuPageState extends State<CompanyMenuPage>
    with AutomaticKeepAliveClientMixin<CompanyMenuPage> {
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
        itemCount: 4,
        itemBuilder: (context, index) {
          return PostInsightItemPage();
        },
      ),
    );
  }
}
