import 'package:feed_box/models/comments_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsTile extends StatefulWidget {
  @override
  _CommentsTileState createState() => _CommentsTileState();
}

class _CommentsTileState extends State<CommentsTile> {
  @override
  Widget build(BuildContext context) {
    final comments = Provider.of<List<CommentModel>>(context) ?? [];
    return FlatButton.icon(
        onPressed: () {},
        icon: Icon(Icons.comment, size: 15),
        label: Text(comments.length == 0 ? '' : '${comments.length}'));
  }
}
