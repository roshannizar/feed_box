import 'package:feed_box/models/profile_model.dart';
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
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings),
              )
            ],
            flexibleSpace: const FlexibleSpaceBar(
              
              centerTitle: true,
              title: Text('Vola'),
            ),
          )
        ];
      },
      body: Container(child: Text('vola')),
    ));
  }
}
