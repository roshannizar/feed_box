import 'package:feed_box/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'activity_tile.dart';

class ActivityList extends StatefulWidget {
  @override
  _ActivityListState createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  @override
  Widget build(BuildContext context) {

    final activityList = Provider.of<List<ActivityModel>>(context) ?? [];

    return activityList.length == 0 ?
    Container(
      alignment: Alignment.center,
      child: Text('Your activity is empty'),
    ):
    ListView.builder(
      shrinkWrap: true,
      itemCount: activityList.length,
      itemBuilder: (context, index) {
        return ActivityTile(activityModel: activityList[index],);
      },
    );
  }
}