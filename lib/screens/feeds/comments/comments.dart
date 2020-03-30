import 'package:feed_box/models/comments_model.dart';
import 'package:feed_box/screens/feeds/comments/comments_tile.dart';
import 'package:feed_box/services/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  final String docid;
  Comments({this.docid});
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CommentModel>>.value(
      value: PostService(uid: widget.docid).getComments,
      child: CommentsTile(),
    );
  }
}