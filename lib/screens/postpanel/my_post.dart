/**
 * My Post rendering class with listview builder
 */

import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/shared/empty.dart';
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
        ? Empty(
            imageUrl: 'assets/empty-inbox.png',
            text: 'Your post is empty',
          )
        : ListView.builder(
            itemCount: myPosts.length,
            itemBuilder: (context, index) {
              return PostTile(myPost: myPosts[index]);
            },
          );
  }
}
