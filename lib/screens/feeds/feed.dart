import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/services/auth_service.dart';
import 'package:feed_box/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feed_list.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final AuthService _authService = AuthService();

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
            elevation: 0,
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  await _authService.signOut();
                },
                icon: Icon(Icons.exit_to_app, color: Colors.blueAccent),
              )
            ],
          ),
          body: Container(
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
