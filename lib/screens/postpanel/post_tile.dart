import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/shared/profile_header.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final PostModel myPost;
  PostTile({this.myPost});

  @override
  Widget build(BuildContext context) {
    if (myPost.description != '') {
      return Container(
          child: Card(
        child: ListTile(
          leading:  ProfileHeader(profile: myPost.uid,type:'Post Tile'),
          title: Text(myPost.description),
          subtitle: Text(myPost.date),
        ),
      ));
    } else {
      return Container(width:0,height: 0,);
    }
  }
}
