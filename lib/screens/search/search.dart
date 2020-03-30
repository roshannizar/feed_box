import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/screens/search/search_list.dart';
import 'package:feed_box/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:feed_box/shared/constant.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ProfileModel>>.value(
      value: ProfileService().allProfile,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Form(
              child: TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Search Feed, Person ...',
                    fillColor: Colors.blueAccent,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.cancel),
              )
            ],
          ),
          body: SearchList(),
        ),
      ),
    );
  }
}
