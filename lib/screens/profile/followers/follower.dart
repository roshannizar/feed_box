/*
  Follower container file
*/

import 'package:feed_box/models/follower_list_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'follower_view_list.dart';

class Follower extends StatefulWidget {
  @override
  _FollowerState createState() => _FollowerState();
}

class _FollowerState extends State<Follower> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final String args = ModalRoute.of(context).settings.arguments;

    return StreamProvider<List<FollowerListModel>>.value(
      value: args == 'Following'
          ? ProfileService(uid: user.uid).getFollowing
          : ProfileService(uid: user.uid).getFollower,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your $args'),
        ),
        body: Container(
          child: FollowerViewList(),
        ),
      ),
    );
  }
}
