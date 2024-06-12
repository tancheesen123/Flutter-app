import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workwise/Controller/NotificationController.dart';
import 'package:workwise/core/app_export.dart';
import 'package:workwise/theme/app_decoration.dart';
import 'package:workwise/theme/custom_text_style.dart';
import 'package:workwise/theme/theme_helper.dart';
import 'package:workwise/widgets/app_bar/appbar_title.dart';
import 'package:workwise/widgets/app_bar/custom_app_bar.dart';
import 'package:workwise/Controller/FirebaseApiController.dart';
import 'package:workwise/Controller/NotificationController.dart';
import '../../../widgets/custom_bottom_bar.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  GlobalKey<CustomBottomBarState> bottomBarKey =
      GlobalKey<CustomBottomBarState>();
  Future<List<Map<String, dynamic>>>? _notificationsFuture;

  final FirebaseApiController firebaseApiController =
      Get.put(FirebaseApiController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  TextEditingController dateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController duration1Controller = TextEditingController();
  List<PendingNotificationRequest> _pendingNotificationRequests = [];
  List<ActiveNotification> _activeNotificationRequests = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = notificationController.fetchNotifications();
    _loadPendingNotifications();
    _handleNotificationAppLaunch();
  }

  void _refreshNotifications() {
    setState(() {
      isLoading = true;
      _notificationsFuture = notificationController.fetchNotifications();
    });
  }

  Future<void> _loadPendingNotifications() async {
    // Load pending notifications
    await firebaseApiController.loadPendingNotifications();

    // Get the pending notifications
    // List<PendingNotificationRequest> pendingNotifications =
    //     FirebaseApi().pendingNotificationRequests;

    List<ActiveNotification> activeNotificationRequests =
        await firebaseApiController.activeNotificationRequests;
    print("This is  active $activeNotificationRequests");
    // Update the state
    // setState(() {
    //   _pendingNotificationRequests = pendingNotifications;
    // });

    setState(() {
      _activeNotificationRequests = activeNotificationRequests;
    });
  }

  void callRefreshActiveNotifications() {
    bottomBarKey.currentState?.refreshActiveNotifications();
  }

  Future<void> _handleNotificationAppLaunch() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      // Handle notification launch here
      print('App launched by tapping on a notification!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
        overlayColor: Colors.black.withOpacity(0.5),
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4.5,
              sigmaY: 4.5,
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0), // Rounded edges
                child: Container(
                  width: 120,
                  height: 100,
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'Please wait...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(context),
            backgroundColor: appTheme.gray50,
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillGray,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text(
                          "Mark All as Read",
                          style: CustomTextStyles.labelLargeGray700,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _notificationsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          if (!isLoading) {
                            context.loaderOverlay.show();
                            isLoading = true;
                          }
                          return SizedBox.shrink();
                        } else {
                          if (isLoading) {
                            context.loaderOverlay.hide();
                            isLoading = false;
                          }
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final notifications = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              final notification = notifications[index];
                              print(
                                  "This is notificationasdasda, $notification");
                              final String jsonString =
                                  notification['notification'];
                              final String status = notification['status'];
                              final String idNotification = notification['id'];
                              final Map<String, dynamic> decodedNotification =
                                  jsonDecode(jsonString);

                              final String token =
                                  decodedNotification['message']['token'];
                              final String title =
                                  decodedNotification['message']['notification']
                                      ['title'];
                              final String body = decodedNotification['message']
                                  ['notification']['body'];

                              final String time = notification['timestamp']
                                      ?.toDate()
                                      .toString() ??
                                  'No timestamp';
                              return InkWell(
                                onTap: () {
                                  // Show a dialog to display the notification ID, title, and body
                                  notificationController
                                      .updateStatus(idNotification);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Notification Details'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text(body ?? "No body"),
                                            _buildBodyText(body ?? "No body"),
                                            // SizedBox(height: 8),
                                            // Text(notification['timestamp']
                                            //         ?.toDate()
                                            //         .toString() ??
                                            //     'No timestamp'),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('Close'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _refreshNotifications();
                                              callRefreshActiveNotifications();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 321,
                                      margin:
                                          EdgeInsets.only(left: 29, right: 24),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            // TextSpan(
                                            //   text: "ID: $idNotification\n\n",
                                            //   style: status == "active"
                                            //       ? CustomTextStyles
                                            //           .titleSmallOnPrimary
                                            //           .copyWith(fontSize: 15.0)
                                            //       : CustomTextStyles
                                            //           .titleSmallGray50001
                                            //           .copyWith(fontSize: 15.0),
                                            // ),
                                            TextSpan(
                                              text: "$title\n",
                                              style: status == "active"
                                                  ? CustomTextStyles
                                                      .titleSmallOnPrimary
                                                      .copyWith(fontSize: 15.0)
                                                  : CustomTextStyles
                                                      .titleSmallGray50001
                                                      .copyWith(fontSize: 15.0),
                                            ),
                                            // TextSpan(
                                            //   text: "Body: $body",
                                            //   style: status == "active"
                                            //       ? CustomTextStyles
                                            //           .bodyMediumOnPrimary_1
                                            //           .copyWith(fontSize: 15.0)
                                            //       : CustomTextStyles
                                            //           .bodyMediumGray50001
                                            //           .copyWith(fontSize: 15.0),
                                            // ),
                                          ],
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 29),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "$time",
                                              style: status == "active"
                                                  ? CustomTextStyles
                                                      .labelLargeOnPrimary
                                                  : CustomTextStyles
                                                      .labelLargeGray50001,
                                            ),
                                            if (status ==
                                                "active") // Conditionally include the Container
                                              Container(
                                                height: 8,
                                                width: 8,
                                                margin: EdgeInsets.only(
                                                    left: 6, top: 4, bottom: 7),
                                                decoration: BoxDecoration(
                                                  color: appTheme.indigo600,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    _buildDivider(),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
// PreferredSizeWidget _buildAppBar(BuildContext context) {
//   return CustomAppBar(
//     centerTitle: true,
//     title: AppbarTitle(
//       text: "Notification",
//     ),
//   );
// }

// Widget _buildDivider() {
//   return Divider(
//     color: appTheme.gray6007f,
//     indent: 29.h,
//     endIndent: 30.h,
//     thickness: 0.5,
//   );
// }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       appBar: _buildAppBar(context),
  //       backgroundColor: appTheme.gray50,
  //       resizeToAvoidBottomInset: false,
  //       body: SingleChildScrollView(
  //         child: Container(
  //           width: double.maxFinite,
  //           decoration: AppDecoration.fillGray,
  //           child: Column(
  //             children: [
  //               SizedBox(height: 20),
  //               Align(
  //                 alignment: Alignment.centerRight,
  //                 child: Padding(
  //                   padding: EdgeInsets.only(right: 30),
  //                   child: Text(
  //                     "Mark All as Read",
  //                     style: CustomTextStyles.labelLargeGray700,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 25),
  //               FutureBuilder<Widget>(
  //                 future: _buildPendingNotifications(),
  //                 builder: (context, snapshot) {
  //                   if (snapshot.connectionState == ConnectionState.waiting) {
  //                     return CircularProgressIndicator();
  //                   } else if (snapshot.hasError) {
  //                     return Text('Error: ${snapshot.error}');
  //                   } else {
  //                     return snapshot.data ?? Container();
  //                   }
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Future<Widget> _buildPendingNotifications() async {
  //   List<ActiveNotification> activeNotificationRequests =
  //       await firebaseApiController.activeNotificationRequests;

  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemCount: activeNotificationRequests.length,
  //     itemBuilder: (context, index) {
  //       final notification = activeNotificationRequests[index];

  //       return InkWell(
  //         onTap: () {
  //           // Show a dialog to display the notification ID, title, and body
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                 title: Text('Notification Details'),
  //                 content: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text('ID: ${notification.id}'),
  //                     SizedBox(height: 8),
  //                     Text('Title: ${notification.title}'),
  //                     SizedBox(height: 8),
  //                     _buildBodyText(notification.body ?? "No body"),
  //                   ],
  //                 ),
  //                 actions: [
  //                   TextButton(
  //                     child: Text('Close'),
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         },
  //         child: Column(
  //           children: [
  //             Container(
  //               width: 321,
  //               margin: EdgeInsets.only(left: 29, right: 24),
  //               child: RichText(
  //                 text: TextSpan(
  //                   children: [
  //                     TextSpan(
  //                       text: "${notification.id} ",
  //                       style: CustomTextStyles.bodyMediumOnPrimary_1
  //                           .copyWith(fontSize: 15.0),
  //                     ),
  //                     TextSpan(
  //                       text: "${notification.title}",
  //                       style: CustomTextStyles.titleSmallOnPrimary
  //                           .copyWith(fontSize: 15.0),
  //                     ),
  //                     TextSpan(
  //                       text: "${notification.body}",
  //                       style: CustomTextStyles.bodyMediumOnPrimary_1
  //                           .copyWith(fontSize: 15.0),
  //                     ),
  //                   ],
  //                 ),
  //                 textAlign: TextAlign.left,
  //               ),
  //             ),
  //             SizedBox(height: 4),
  //             Align(
  //               alignment: Alignment.centerLeft,
  //               child: Padding(
  //                 padding: EdgeInsets.only(left: 29),
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       "10 min ago",
  //                       style: CustomTextStyles.labelLargeOnPrimary,
  //                     ),
  //                     Container(
  //                       height: 8,
  //                       width: 8,
  //                       margin: EdgeInsets.only(left: 6, top: 4, bottom: 7),
  //                       decoration: BoxDecoration(
  //                         color: appTheme.indigo600,
  //                         borderRadius: BorderRadius.circular(4),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             _buildDivider(),
  //             SizedBox(height: 20),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

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
        textSpans
            .add(TextSpan(text: body.substring(lastMatchEnd, match.start)));
      }
      final String linkText = match.group(0)!;
      textSpans.add(
        TextSpan(
          text: linkText,
          style: TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () => _launchURL(linkText),
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(
        text: "Notification",
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: appTheme.gray6007f,
      indent: 29.h,
      endIndent: 30.h,
      thickness: 0.5,
    );
  }
}
