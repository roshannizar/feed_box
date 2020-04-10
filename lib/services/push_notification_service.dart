import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifcationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  //push notification
  Future initialise() async {

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
    );
    //permission request
    _fcm.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        alert: true,
        badge: true
      )
    );

    _fcm.onIosSettingsRegistered.listen((onData){
      print(onData.toString());
    });

    _fcm.getToken().then((token) {
      print('tokennnnnnnnnnnnnnnnnnnnnnnnnnnnnnn $token');
    });
  }
}
