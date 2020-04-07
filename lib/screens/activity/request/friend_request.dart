import 'package:flutter/material.dart';

class FriendRequest extends StatefulWidget {
  @override
  _FriendRequestState createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Friend Request(s)'),
        subtitle: Text('0'),
        trailing: IconButton(icon: Icon(Icons.arrow_right),onPressed: (){}),
      ),
    );
  }
}