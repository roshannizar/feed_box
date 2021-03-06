/**
 * Search main class rendering the listview of the users
 */

import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/screens/search/search_list.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:flutter/material.dart';
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
            backgroundColor: Colors.white,
            title: Text('All Users',style: TextStyle(color: Colors.black))
          ),
          body: SearchList(),
        ),
      ),
    );
  }
}
