import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_container.dart';

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
            ProfileModel profileModel = snapshot.data;

            return ProfileContainer(profile: profileModel);
          } else {
            return Container();
          }
        });
  }
}
