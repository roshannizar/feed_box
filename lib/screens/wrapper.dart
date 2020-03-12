import 'package:feed_box/models/user.dart';
import 'package:feed_box/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feed_box/screens/home/home.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return user != null ? Home(): Authenticate();
  }
}