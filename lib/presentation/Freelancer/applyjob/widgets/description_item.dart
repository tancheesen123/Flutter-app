import 'package:flutter/material.dart' hide SearchController;
import 'package:workwise/widgets/custom_text_form_field.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/custom_icon_button.dart'; // ignore: must_be_immutable

class DescriptionItemWidget extends StatelessWidget {
  const DescriptionItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Chargee MY - ",
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
              WidgetSpan(
                child: Icon(
                  Icons.location_on_outlined,
                  size: 24,
                ),
              ),
              TextSpan(
                text: "Intermark Mall, KL",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.v), // Adjust as needed
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "Chargee MY - ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 24,
                      ),
                    ),
                    TextSpan(
                      text: "Intermark Mall, KL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
