import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/shared/profile_header.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final PostModel myPost;
  PostTile({this.myPost});

  @override
  Widget build(BuildContext context) {
    if (myPost.description != '') {
      return Card(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Image.network('${myPost.postUrl}'),
            SizedBox(height: 5),
            Text('${myPost.description}'),
            ListTile(
              trailing: Tooltip(
                message: myPost.date,
                child: Icon(Icons.info),
              ),
            ),
          ],
        ),
      ));
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }
}
