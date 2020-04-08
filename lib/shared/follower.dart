import 'package:feed_box/models/follower_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'follower_tile.dart';

class Follower extends StatefulWidget {
  final Stream<List<FollowerListModel>> streamFunction;
  final String type;
  Follower({this.streamFunction, this.type});
  @override
  _FollowerState createState() => _FollowerState();
}

class _FollowerState extends State<Follower> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<FollowerListModel>>.value(
      value: widget.streamFunction,
      child: FollowerTile(
        type: widget.type,
      ),
    );
  }
}
