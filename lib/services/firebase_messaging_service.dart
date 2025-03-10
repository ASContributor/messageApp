import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  FirebaseMessagingService._privateConstructor();

  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._privateConstructor();

  factory FirebaseMessagingService() {
    return _instance;
  }

  static FirebaseMessagingService get instance => _instance;

  Future<void> initializeFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      if (token != null) {
        await FirebaseFirestore.instance
            .collection('deviceTokens')
            .doc(token)
            .set({'token': token});
      }
    }
  }
}
