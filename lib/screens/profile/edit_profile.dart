import 'package:flutter/material.dart';

import 'edit_tile.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Edit Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10,10,10,0),
        child: ListView(
          children: <Widget>[EditTile()],
        ),
      ),
    );
  }
}
