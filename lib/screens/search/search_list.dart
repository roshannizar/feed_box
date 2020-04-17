import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feed_box/screens/search/search_tile.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final profiles = Provider.of<List<ProfileModel>>(context) ?? [];

    return profiles.length == 0
        ? Loading()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              if (profiles[index].uid == user.uid) {
                return SizedBox(height: 0, width: 0);
              } else {
                return SearchTile(profile: profiles[index]);
              }
            },
          );
  }
}
