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
            backgroundColor: Colors.blue,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(color: Colors.blue,),
              title: Text('${widget.profile.fullname}'),
            ),
          )
        ];
      },
      body: Container(child: Text('vola')),
    ));
  }
}
