import 'package:feed_box/screens/postpanel/bottom_panel.dart';
import 'package:feed_box/screens/profile/edit_profile.dart';
import 'package:feed_box/screens/profile/followers/follower.dart';
import 'package:feed_box/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';
import 'services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => Wrapper(),
            '/newpost': (context) => BottomPanel(),
            '/editprofile':(context) => EditProfile(),
            '/follower':(context) => Follower()
          },
        ));
  }
}
