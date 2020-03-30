import 'package:feed_box/models/like_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeTile extends StatefulWidget {
  final String docid;
  LikeTile({this.docid});
  @override
  _LikeTileState createState() => _LikeTileState();
}

class _LikeTileState extends State<LikeTile> {
  bool liked = false;
  String likedocid;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final likesList = Provider.of<List<LikeModel>>(context) ?? [];

    likesList.forEach((f) {
      if (f.profile == user.uid) {
        liked = true;
        likedocid = f.likedocid;
      }
    });

    return FlatButton.icon(
        onPressed: () async {
          await PostService().newLike(user.uid, widget.docid, likedocid, liked);
          setState(() {
            liked = false;
          });
        },
        icon: Icon(
          liked ? Icons.favorite : Icons.favorite_border,
          size: 15,
          color: liked ? Colors.red : Colors.black,
        ),
        label: Text(likesList.length == 0 ? '' : '${likesList.length}'));
  }
}
