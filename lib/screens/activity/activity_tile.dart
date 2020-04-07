import 'package:feed_box/models/activity_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/shared/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityTile extends StatefulWidget {
  final ActivityModel activityModel;
  ActivityTile({this.activityModel});
  @override
  _ActivityTileState createState() => _ActivityTileState();
}

class _ActivityTileState extends State<ActivityTile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top:10),
      child: ListTile(
        leading: Container(width: 50,height: 50,child: ProfileHeader(profile: user.uid)),
        title: Text("${widget.activityModel.title}"),
        subtitle: Text('${widget.activityModel.date}'),
        trailing: Tooltip(message: 'Coming soon',child: Icon(Icons.local_activity,color: Colors.green)),
      ),
    );
  }
}