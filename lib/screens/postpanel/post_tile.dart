import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/screens/feeds/comments/comments.dart';
import 'package:feed_box/screens/feeds/components/feed_image.dart';
import 'package:feed_box/screens/feeds/components/feed_player.dart';
import 'package:feed_box/screens/feeds/likes/likes.dart';
import 'package:feed_box/screens/feeds/share/share.dart';
import 'package:feed_box/shared/profile_header.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final PostModel myPost;
  PostTile({this.myPost});

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
                ProfileHeader(profile: myPost.uid, type: 'Feed'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text('${myPost.fullname}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        '${myPost.date}',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Text('${myPost.description}'),
            ),
            (myPost.image != "null" && myPost.image != "")
                ? FeedImage(url: myPost.postUrl)
                : (myPost.video != '' && myPost.video != 'null')
                    ? FeedPlayer(url: myPost.postUrl)
                    : SizedBox(height: 0, width: 0),
            Divider(color: Colors.grey[400]),
            Wrap(
              children: <Widget>[
                Likes(docid: myPost.documentId),
                Comments(docid: myPost.documentId),
                ShareContainer(
                    postUrl: myPost.postUrl, description: myPost.description)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
