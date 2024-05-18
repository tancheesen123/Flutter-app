import 'package:flutter/material.dart' hide SearchController;
import 'package:workwise/widgets/custom_text_form_field.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/custom_icon_button.dart'; // ignore: must_be_immutable

class DescriptionItemWidget extends StatefulWidget {
  final String? description;
  const DescriptionItemWidget({Key? key, this.description})
      : super(
          key: key,
        );

  @override
  State<DescriptionItemWidget> createState() => _DescriptionItemWidgetState();
}

class _DescriptionItemWidgetState extends State<DescriptionItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Job Description",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
        ),
        SizedBox(height: 20.v), // Adjust as needed
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: "• ${widget.description}",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
