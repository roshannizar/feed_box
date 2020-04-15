import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/screens/postpanel/post_panel.dart';
import 'package:feed_box/services/auth_service.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatefulWidget {
  final ProfileModel profile;
  ProfileContainer({this.profile});
  @override
  _ProfileContainerState createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            floating: true,
            pinned: true,
            backgroundColor: Colors.blue,
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  await AuthService().signOut();
                },
                icon: Icon(Icons.exit_to_app),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/editprofile');
                },
                icon: Icon(Icons.edit),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/maxresdefault.jpg'),fit: BoxFit.cover)
                ),
                    child:CircleAvatar(
                      radius: 50,
                        backgroundImage:
                            NetworkImage('${widget.profile.profileUrl}'))
              ),
              title: Text('${widget.profile.fullname}'),
            ),
          )
        ];
      },
      body: PostPanel(),
    ));
  }
}
