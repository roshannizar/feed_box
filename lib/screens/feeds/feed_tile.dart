import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/screens/feeds/components/feed_image.dart';
import 'package:feed_box/shared/profile_header.dart';
import 'package:flutter/material.dart';

import 'comments/comments.dart';
import 'components/feed_player.dart';
import 'likes/likes.dart';
import 'share/share.dart';

class FeedTile extends StatelessWidget {
  final PostModel post;
  FeedTile({this.post});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.fromLTRB(4, 5, 4, 5),
      decoration: new BoxDecoration(
          color: Colors.grey[100],
          borderRadius: new BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                ProfileHeader(profile: post.uid, type: 'Feed'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text('${post.fullname}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        '${post.date}',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Text('${post.description}'),
            ),
            (post.image != "null" && post.image != "")
                ? FeedImage(url: post.postUrl)
                : (post.video != '' && post.video != 'null')
                    ? FeedPlayer(url: post.postUrl)
                    : SizedBox(height: 0, width: 0),
            Divider(color: Colors.grey[400]),
            Wrap(
              children: <Widget>[
                Likes(docid: post.documentId,uid: post.uid),
                Comments(docid: post.documentId),
                ShareContainer(
                    postUrl: post.postUrl, description: post.description)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
