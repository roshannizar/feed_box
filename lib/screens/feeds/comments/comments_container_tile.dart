import 'package:feed_box/models/comments_model.dart';
import 'package:feed_box/shared/profile_header.dart';
import 'package:flutter/material.dart';

class CommentsContainerTile extends StatefulWidget {
  final CommentModel comment;
  CommentsContainerTile({this.comment});
  @override
  _CommentsContainerTileState createState() => _CommentsContainerTileState();
}

class _CommentsContainerTileState extends State<CommentsContainerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        child: ProfileHeader(
            profile: widget.comment.profile,
            content: widget.comment.content,
            type: 'Comments'));
  }
}
