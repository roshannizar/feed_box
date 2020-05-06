/**
 * Comments rendering component by importing bottomsheet
 */

import 'package:feed_box/models/comments_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'comments_container.dart';

class CommentsTile extends StatefulWidget {
  final String docid;
  CommentsTile({this.docid});
  @override
  _CommentsTileState createState() => _CommentsTileState();
}

class _CommentsTileState extends State<CommentsTile> {

  void _showCommentsPanel() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: CommentsContainer(docid: widget.docid),
          );
        });
  }
  
  @override
  Widget build(BuildContext context) {
    final comments = Provider.of<List<CommentModel>>(context) ?? [];

    return FlatButton.icon(
        onPressed: () {
          _showCommentsPanel();
        },
        icon: Icon(Icons.comment, size: 15),
        label: Text(comments.length == 0 ? 'Comment' : comments.length ==1 ?'${comments.length} Comment':'${comments.length} Comments'));
  }
}
