import 'package:feed_box/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feed_box/screens/home/feed_tile.dart';

class FeedList extends StatefulWidget {
  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostModel>>(context) ?? [];

    return posts.length == 0
        ? Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 Image.asset('assets/empty-inbox.png',width: 200),
                 SizedBox(height: 20,),
                 Text('You have not posted anything!',textAlign: TextAlign.center,style: TextStyle(fontSize: 16),)
                ],
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return FeedTile(post: posts[index]);
            },
          );
  }
}
