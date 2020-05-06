/**
 * FeedList view class checking users post and following
 */

import 'package:feed_box/models/follower_list_model.dart';
import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/shared/empty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feed_tile.dart';

class FeedList extends StatefulWidget {
  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  List<PostModel> feedList = [];
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostModel>>(context) ?? [];
    final followerList = Provider.of<List<FollowerListModel>>(context) ?? [];

    //checks the post is empty or not
    if (posts.isNotEmpty) {
      //looping throw post and follower to check whether user has followed him/her
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

      //remove value duplication
      feedList.toSet().toList();
    }

    return feedList.length == 0
        ? Empty(
            imageUrl: 'assets/empty-inbox.png',
            text: 'Start following someone to view their post',
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: feedList.isNotEmpty
                ? feedList.toSet().toList().length
                : feedList.length,
            itemBuilder: (context, index) {
              return FeedTile(post: feedList[index]);
            },
          );
  }
}
