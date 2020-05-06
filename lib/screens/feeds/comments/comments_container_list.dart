/**
 * comments list container view with listview builder
 */

import 'package:feed_box/models/comments_model.dart';
import 'package:feed_box/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'comments_container_tile.dart';

class CommentsContainerList extends StatefulWidget {
  @override
  _CommentsContainerListState createState() => _CommentsContainerListState();
}

class _CommentsContainerListState extends State<CommentsContainerList> {
  @override
  Widget build(BuildContext context) {

    final comments = Provider.of<List<CommentModel>>(context) ?? [];

    return comments.length == 0 ? Loading() :  ListView.builder(
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return CommentsContainerTile(comment: comments[index]);
            },
          );
  }
}