import 'package:feed_box/models/follower_list_model.dart';
import 'package:feed_box/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feed_tile.dart';

class FeedList extends StatefulWidget {
  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  List<PostModel> feedList =[];
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostModel>>(context) ?? [];
    final followerList = Provider.of<List<FollowerListModel>>(context) ?? [];

     if(posts.isNotEmpty) {

    posts.forEach((p) {
      followerList.forEach((f) {
        if (p.uid == f.friendUid) {
          feedList.add(PostModel(
              date: p.date,
              description: p.description,
              documentId: p.documentId,
              fullname: p.fullname,
              image: p.image,
              postUrl: p.postUrl,
              title: p.title,
              uid: p.uid,
              video: p.video));
        }
      });
    });

    feedList.toSet().toList();
    }

    return posts.length == 0
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
            shrinkWrap: true,
            itemCount: 
    feedList.isNotEmpty? feedList.toSet().toList().length:feedList.length,
            itemBuilder: (context, index) {
              return FeedTile(post: feedList[index]);
            },
          );
  }
}
