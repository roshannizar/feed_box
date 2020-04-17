import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatefulWidget {
  final String profile, content, type, title; // takes a parameter since its using shared class
  final bool titleDirection; // checks whether current user
  ProfileHeader(
      {this.profile, this.content, this.type, this.title, this.titleDirection}); //initializing parameter
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context); //current user uid loaded

    return StreamBuilder<ProfileModel>(
        stream: ProfileService(uid: widget.profile).profileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ProfileModel profileModel = snapshot.data;

            if (widget.type == 'Comments') { // check the type of parameter screen
              return ListTile(
                leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage('${profileModel.profileUrl}')),
                title: Text('${profileModel.fullname}'),
                subtitle: Text('${widget.content}'),
              );
            } else if (widget.type == 'activity') { // check the type of parameter screen
              return widget.profile == user.uid
                  ? Text("${widget.title}")
                  : Text(widget.titleDirection
                      ? '${profileModel.fullname} ${widget.title}'
                      : '${widget.title} ${profileModel.fullname}'); // this works according to the activity to be shown
            } else if (widget.type == 'title') {
              return Text('${profileModel.fullname}');
            } else {
              return CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${profileModel.profileUrl}'));
            }
          } else {
            return Container(); // no values return  default value
          }
        });
  }
}
