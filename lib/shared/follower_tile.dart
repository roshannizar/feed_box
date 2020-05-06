/**
 * Follower tile class
 */

import 'package:feed_box/models/follower_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowerTile extends StatefulWidget {
  final String type; // eg: Follower or Following
  FollowerTile({this.type});
  @override
  _FollowerTileState createState() => _FollowerTileState();
}

class _FollowerTileState extends State<FollowerTile> {
  @override
  Widget build(BuildContext context) {
    final followerCount = Provider.of<List<FollowerListModel>>(context) ?? [];

    return FlatButton(
      child: Text(
          '${widget.type} ${widget.type == 'Following' ? followerCount.length - 1 : followerCount.length}'), //checks the length of the follower and acts upon it
      onPressed: () {
        Navigator.pushNamed(context, '/follower',arguments: widget.type);
      },
    );
  }
}
