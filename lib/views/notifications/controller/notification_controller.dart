import 'package:fenwicks_admin/meta/widgets/loading.dart';
import 'package:fenwicks_admin/meta/widgets/snack_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();

  void sendNotification() async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);
      // send http request
      final url = Uri.parse("https://us-central1-fenwicks-pub-a46a5.cloudfunctions.net/sendNotifications");

      final res = await http.post(
        url,
        body: {
          "title": title.text.trim(),
          "body": body.text.trim(),
        },
      );

      // // throw error
      // if (res.statusCode == 404) throw res.body;
      // show status is good and clear fields
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 3),
          title: "Success",
          messageText: Text(
            "Notification has been sent",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Baloo",
              color: material.Colors.white,
            ),
          ),
          backgroundColor: material.Colors.green,
        ),
      );
      title.clear();
      body.clear();
      Get.back();
    } catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.toString()));
    }
  }

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  // final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("orders");

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(body ?? ""),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {},
          )
        ],
      ),
    );
  }

  @override
  void onInit() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    //
    const initialzationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    //
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    //
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;

      if (notification != null && android != null && apple != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: "@mipmap/ic_launcher",
            ),
            iOS: const IOSNotificationDetails(),
          ),
        );
      }
    });

    //
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;
      if (notification != null && android != null && apple != null) {
        Get.showSnackbar(
          GetSnackBar(
            title: notification.title,
            message: notification.body,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

    //
    super.onInit();
  }
}
