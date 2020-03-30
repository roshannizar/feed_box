import 'package:feed_box/models/like_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeTile extends StatefulWidget {
  @override
  _LikeTileState createState() => _LikeTileState();
}

class _LikeTileState extends State<LikeTile> {
  bool liked=false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final likesCount = Provider.of<List<LikeModel>>(context) ?? [];

    likesCount.forEach((f) {
      if (f.profile == user.uid) {
        liked = true;
      }
    });

    return FlatButton.icon(
        onPressed: () {},
        icon: Icon(
          liked ? Icons.favorite : Icons.favorite_border,
          size: 15,
          color: liked ? Colors.red : Colors.black,
        ),
        label: Text('${likesCount.length}'));
  }
}
