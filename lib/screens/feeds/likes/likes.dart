import 'package:feed_box/models/like_model.dart';
import 'package:feed_box/screens/feeds/likes/like_tile.dart';
import 'package:feed_box/services/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Likes extends StatefulWidget {
  final String docid;
  Likes({this.docid});
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<LikeModel>>.value(
        value: PostService(uid: widget.docid).likes,
        child: LikeTile());
  }
}
