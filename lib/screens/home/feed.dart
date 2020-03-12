import 'package:feed_box/models/post.dart';
import 'package:feed_box/services/auth.dart';
import 'package:feed_box/services/post.dart';
import 'package:flutter/material.dart';
import 'package:feed_box/screens/home/feed_list.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final AuthService _authService = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Post>>.value(
      value: PostService().posts,
          child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Feed Box',
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),
            ),
            elevation: 0,
            actions: <Widget>[
              IconButton(
                onPressed: () async{
                  await _authService.signOut();
                },
                icon: Icon(Icons.exit_to_app,color: Colors.blueAccent),
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
