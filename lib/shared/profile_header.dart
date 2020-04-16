import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatefulWidget {
  final String profile, content, type, title;
  final bool titleDirection;
  ProfileHeader(
      {this.profile, this.content, this.type, this.title, this.titleDirection});
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
            } else if (widget.type == 'activity') {
              return Text(widget.titleDirection
                  ? '${profileModel.fullname} ${widget.title}'
                  : '${widget.title} ${profileModel.fullname}');
            } else if(widget.type == 'title'){
              return Text('${profileModel.fullname}');
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
