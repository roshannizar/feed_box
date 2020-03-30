import 'package:feed_box/screens/messages/chat.dart';
import 'package:feed_box/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';
import 'services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: MaterialApp(
          initialRoute: '/',
          routes: {'/': (context) => Wrapper(), '/chat': (context) => Chat()},
        ));
  }
}
