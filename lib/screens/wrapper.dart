/**
 * Wrapper class to laod signin on auth using UserModel provider
 * checks whether the user is loggedin or not
 */

import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feed_box/screens/home/home.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    return user != null ? Home(): Authenticate(); // main screen to check whether user has logged in 
  }
}