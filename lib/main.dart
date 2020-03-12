import 'package:feed_box/models/user.dart';
import 'package:feed_box/screens/wrapper.dart';
import 'package:feed_box/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper()
      )
    );
  }
}
