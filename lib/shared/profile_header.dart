import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatefulWidget {
  final String profile, content, type;
  ProfileHeader({this.profile, this.content, this.type});
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfileModel>(
        stream: ProfileService(uid: widget.profile).profileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ProfileModel profileModel = snapshot.data;

            if (widget.type == 'Comments') {
              return ListTile(
                leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage('${profileModel.profileUrl}')),
                title: Text('${profileModel.fullname}'),
                subtitle: Text('${widget.content}'),
              );
            } else {
              return CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${profileModel.profileUrl}'));
            }
          } else {
            return Container();
          }
        });
  }
}
