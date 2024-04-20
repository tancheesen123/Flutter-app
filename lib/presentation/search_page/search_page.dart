import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/orderdetails_item_widget.dart'; // ignore_for_file: must_be_immutable

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key})
      : super(
          key: key,
        );

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
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
          return OrderdetailsItemWidget();
        },
      ),
    );
  }
}
