import 'package:feed_box/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feed_box/screens/postpanel/post_tile.dart';

class MyPost extends StatefulWidget {
  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  @override
  Widget build(BuildContext context) {
    final myPosts = Provider.of<List<PostModel>>(context) ?? [];

    return myPosts.isEmpty
        ? Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/empty-inbox.png', width: 200),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You have not posted anything!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          )
        : ListView.builder(
            itemCount: myPosts.length,
            itemBuilder: (context, index) {
              return PostTile(myPost: myPosts[index]);
            },
          );
  }
}
