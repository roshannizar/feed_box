import 'package:feed_box/models/activity_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/screens/activity/activity_list.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    return StreamProvider<List<ActivityModel>>.value(
      value:ProfileService(uid: user.uid).allActivity,
          child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Activity',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ActivityList()
      ),
    );
  }
}
