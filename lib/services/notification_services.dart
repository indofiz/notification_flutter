import 'package:belajar/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../page/berita_page.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationServices.instance.setupFlutterNotifications();
  await NotificationServices.instance.showNotification(message);
}

@pragma('vm:entry-point')
void backgroundNotificationHandler(NotificationResponse response) {
  // Logika untuk menangani notifikasi dari latar belakang
  if (response.payload == 'berita') {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const BeritaPage(),
      ),
    );
  }
}

class NotificationServices {
  NotificationServices._();
  static final NotificationServices instance = NotificationServices._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterNotificationInitialized = false;

  Future<void> initialize() async {
    try {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      // Request permission
      await _requestPermission();

      // Setup message handlers
      await _setupMessageHandlers();

      // Setup local notifications
      await setupFlutterNotifications();

      // Handle APNs token (Optional: Hanya log error jika gagal)
      try {
        String? apnsToken = await _messaging.getAPNSToken();
        if (apnsToken == null) {
          print('APNs Token belum tersedia.');
        } else {
          print('APNs Token: $apnsToken');
        }
      } catch (e) {
        print('Gagal mendapatkan APNs Token: $e');
      }

      // Handle FCM token
      try {
        final token = await _messaging.getToken();
        print('FCM Token: $token');
      } catch (e) {
        print('Gagal mendapatkan FCM Token: $e');
      }

      // Subscribe to topic
      subscribeToTopic('berita');
    } catch (e, stackTrace) {
      // Tangkap error dan log stack trace
      print('Error saat inisialisasi NotificationServices: $e');
      print(stackTrace);
    }
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    print('Permission Status : ${settings.authorizationStatus}');
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterNotificationInitialized) {
      return;
    }

    //android setup
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initialitaionSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //ios setup
    final initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        //ios setting
      },
    );

    final initializationSettings = InitializationSettings(
      android: initialitaionSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotifications.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            backgroundNotificationHandler);

    _isFlutterNotificationInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data['type'].toString(),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    //foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    //background message
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleBackgroundMessage(message.data['type']);
    });

    //opened app
    final initialMessage = await _messaging.getInitialMessage();

    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage.data['type']);
    }
  }

  void _handleBackgroundMessage(String message) {
    if (message == 'berita') {
      //Open chat Screen
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const BeritaPage(),
        ),
      );
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }
}
