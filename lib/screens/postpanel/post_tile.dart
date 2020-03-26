import 'package:feed_box/models/post.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final Post myPost;
  PostTile({this.myPost});

  @override
  Widget build(BuildContext context) {
    if (myPost.description != '') {
      return Container(
          child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
          ),
          title: Text(myPost.description),
          subtitle: Text(myPost.date),
        ),
      ));
    } else {
      return Container(width:0,height: 0,);
    }
  }
}
