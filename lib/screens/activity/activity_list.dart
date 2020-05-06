/**
 * Activity list container with listview builder
 */

import 'package:feed_box/models/activity_model.dart';
import 'package:feed_box/shared/empty.dart';
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

    return activityList.length == 0
        ? Empty(imageUrl: 'assets/activation.png',text: 'No activity has been tracked now',)
        : ListView.separated(
            shrinkWrap: true,
            itemCount: activityList.length,
            itemBuilder: (context, index) {
              return ActivityTile(
                activityModel: activityList[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          );
  }
}
