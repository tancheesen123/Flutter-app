import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:workwise/Controller/UserController.dart';

class FirebaseApiController extends GetxController {
  static FirebaseApiController instance = Get.find();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<PendingNotificationRequest> _pendingNotificationRequests = [];
  List<ActiveNotification> _activeNotificationRequests = [];

  final AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    final UserController userController = Get.put(UserController());

    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await _firebaseMessaging.getToken();
      print('FirebaseMessaging token: $token');
      userController.addToken("$token");

      await initLocalNotification();
      await initPushNotification();
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
  }

  void handleMessage(RemoteMessage? message) {
    if (message != null) {
      print('Handling a message: ${message.messageId}');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
    }
  }

  Future<void> initLocalNotification() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android, iOS: ios);
    await localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final String? payload = response.payload;
        if (payload != null) {
          final message = RemoteMessage.fromMap(jsonDecode(payload));
          handleMessage(message);
        }
      },
    );
  }

  Future<void> loadPendingNotifications() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await localNotification.pendingNotificationRequests();
    print("This is pendingNotificationRequests: $pendingNotificationRequests");

    final List<ActiveNotification> activeNotifications =
        await localNotification.getActiveNotifications();

    print("This is activeNotifications: ${activeNotifications.length}");
    for (var notification in activeNotifications) {
      print('ActiveNotification ID: ${notification.id}');
      print('ActiveNotification Title: ${notification.title}');
      print('ActiveNotification Body: ${notification.body}');
    }
    _pendingNotificationRequests = pendingNotificationRequests;
    _activeNotificationRequests = activeNotifications;
  }

  List<PendingNotificationRequest> get pendingNotificationRequests {
    return _pendingNotificationRequests;
  }

  List<ActiveNotification> get activeNotificationRequests {
    print("is the value empty? $_activeNotificationRequests");
    return _activeNotificationRequests;
  }

  Future<void> initPushNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    //FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidChannel.id,
              androidChannel.name,
              channelDescription: androidChannel.description,
              importance: Importance.high,
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }
}
