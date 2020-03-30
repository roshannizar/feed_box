import 'package:feed_box/models/profile.dart';
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
            backgroundColor: Colors.blueGrey,
          ),
          title: Text('${profile.fullname}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('@${profile.email}'),
          trailing: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/chat',arguments: ProfileModel(email: profile.email,fullname: profile.fullname,uid: profile.uid),
                  );
            },
            icon: Icon(Icons.chat, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
