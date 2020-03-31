import 'package:feed_box/models/comments_model.dart';
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
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.amber),
        title: Text('${widget.comment.profile}'),
        subtitle: Text('${widget.comment.content}'),
      ),
    );
  }
}
