import 'package:flutter/material.dart';

class Follow extends StatefulWidget {
  @override
  _FollowState createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.add_box,color: Colors.blue),
              onPressed: () {},
            )));
  }
}
