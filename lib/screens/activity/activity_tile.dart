import 'package:feed_box/models/activity_model.dart';
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
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.blue),
        title: Text(widget.activityModel.status? 'You liked a post':'You unliked a post'),
        subtitle: Text('${widget.activityModel.date}'),
      ),
    );
  }
}