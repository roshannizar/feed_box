import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<ProfileModel>(
        stream: ProfileService(uid: user.uid).profileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(title: Text('')),
            );
          } else {
            return Container();
          }
        });
  }
}
