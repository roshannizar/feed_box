import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/screens/feeds/comments/comments.dart';
import 'package:feed_box/screens/feeds/likes/likes.dart';
import 'package:feed_box/shared/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';

class FeedTile extends StatelessWidget {
  final PostModel post;
  FeedTile({this.post});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text('${post.fullname}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Expanded(
                  child: Container(
                      height: 20,
                      width: 10,
                      alignment: Alignment.centerRight,
                      child: Tooltip(message: 'posted on ${post.date}',child: Icon(Icons.info))),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Text('${post.description}'),
            ),
            Container(
              child: Image.network('${post.postUrl}', loadingBuilder:
                  (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                }
              }),
            ),
            Divider(color: Colors.grey[700]),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Likes(docid: post.documentId),
                  Comments(docid: post.documentId),
                  FlatButton.icon(
                      onPressed: () {
                        Share.share('${post.postUrl}',
                            subject: '${post.description}');
                      },
                      icon: Icon(Icons.share, size: 15),
                      label: Text('Share')),
                  (user.uid == post.uid)
                      ? Container()
                      : FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.add, size: 15),
                          label: Text('Follow')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
