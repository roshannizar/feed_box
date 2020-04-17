import 'package:feed_box/models/activity_model.dart';
import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/screens/feeds/comments/comments.dart';
import 'package:feed_box/screens/feeds/components/feed_image.dart';
import 'package:feed_box/screens/feeds/components/feed_player.dart';
import 'package:feed_box/screens/feeds/likes/likes.dart';
import 'package:feed_box/screens/feeds/share/share.dart';
import 'package:feed_box/services/post_service.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:feed_box/shared/profile_header.dart';
import 'package:flutter/material.dart';

class PostTile extends StatefulWidget {
  final PostModel myPost;
  PostTile({this.myPost});
  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
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
                ProfileHeader(profile: widget.myPost.uid, type: 'Feed'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text('${widget.myPost.fullname}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        '${widget.myPost.date}',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () async {
                          await PostService().deletePost(widget.myPost.documentId);
                          await ProfileService(uid: widget.myPost.uid).newActivity(ActivityModel(title: 'You have delete a post',uid: widget.myPost.uid,receiverUid: widget.myPost.uid));
                          
                          setState(() {
                            
                          });
                        },
                        icon: Icon(Icons.delete)),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Text('${widget.myPost.description}'),
            ),
            (widget.myPost.image != "null" && widget.myPost.image != "")
                ? FeedImage(url:widget.myPost.postUrl)
                : (widget.myPost.video != '' && widget.myPost.video != 'null')
                    ? FeedPlayer(url: widget.myPost.postUrl)
                    : SizedBox(height: 0, width: 0),
            Divider(color: Colors.grey[400]),
            Wrap(
              children: <Widget>[
                Likes(docid: widget.myPost.documentId),
                Comments(docid: widget.myPost.documentId),
                ShareContainer(
                    postUrl: widget.myPost.postUrl, description: widget.myPost.description)
              ],
            ),
          ],
        ),
      ),
    );
  }
}