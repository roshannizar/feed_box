import 'package:feed_box/models/profile_model.dart';
import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  final ProfileModel profile;
  SearchTile({this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('${profile.profileUrl}'),
          ),
          title: Text('${profile.fullname}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('@${profile.email}'),
          trailing: FlatButton.icon(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {},
              icon: Icon(Icons.add, color: Colors.white),
              label: Text('Follow', style: TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}
