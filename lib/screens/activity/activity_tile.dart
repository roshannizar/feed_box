/**
 * Activity list component rendering class
 */

import 'package:feed_box/models/activity_model.dart';
import 'package:feed_box/shared/profile_header.dart';
import 'package:flutter/material.dart';

class ActivityTile extends StatefulWidget {
  final ActivityModel activityModel;
  ActivityTile({this.activityModel});
  @override
  _ActivityTileState createState() => _ActivityTileState();
}

class _ActivityTileState extends State<ActivityTile> {
  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: ListTile(
        leading: Container(
            width: 50, height: 50, child: ProfileHeader(profile: widget.activityModel.receiverUid)),
        title: ProfileHeader(
            type: 'activity',
            title: widget.activityModel.title,
            profile: widget.activityModel.receiverUid,
            titleDirection: widget.activityModel.titleDirection),
        subtitle: Text('${widget.activityModel.date}'),
        trailing: Tooltip(
            message: 'Coming soon',
            child: Icon(Icons.local_activity, color: Colors.green)),
      ),
    );
  }
}
