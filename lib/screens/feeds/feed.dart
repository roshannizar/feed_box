import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feed_list.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>>.value(
      value: PostService().posts,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Feed Box',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(top: 5),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: FeedList(),
                ),
              ],
            ),
          )),
    );
  }
}
