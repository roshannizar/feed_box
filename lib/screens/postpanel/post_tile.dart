import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/screens/feeds/comments/comments.dart';
import 'package:feed_box/screens/feeds/follow/follow.dart';
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
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network('${myPost.postUrl}', loadingBuilder:
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
            ),
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
