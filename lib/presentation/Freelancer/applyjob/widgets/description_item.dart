import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
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
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SizedBox(height: 20), // Adjust as needed
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15), // Adjust as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10), // Adjust as needed
                child: _buildBodyText(widget.description ?? "No body"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildBodyText(String body) {
  final RegExp linkRegExp = RegExp(r'http[s]?:\/\/[^\s]+');
  final Iterable<RegExpMatch> matches = linkRegExp.allMatches(body);

  if (matches.isEmpty) {
    return Text(body);
  }

  List<TextSpan> textSpans = [];
  int lastMatchEnd = 0;

  for (final match in matches) {
    if (match.start != lastMatchEnd) {
      textSpans.add(TextSpan(text: body.substring(lastMatchEnd, match.start)));
    }
    final String linkText = match.group(0)!;
    textSpans.add(
      TextSpan(
        text: linkText,
        style:
            TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
        recognizer: TapGestureRecognizer()..onTap = () => _launchURL(linkText),
      ),
    );
    lastMatchEnd = match.end;
  }

  if (lastMatchEnd != body.length) {
    textSpans.add(TextSpan(text: body.substring(lastMatchEnd)));
  }

  return RichText(
    text: TextSpan(
      style: CustomTextStyles.bodyMediumOnPrimary_1.copyWith(fontSize: 15.0),
      children: textSpans,
    ),
  );
}

void _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
