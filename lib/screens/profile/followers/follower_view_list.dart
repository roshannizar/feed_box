/*
Follower list file where all the follower will be loaded based on the parameter
*/ 

import 'package:feed_box/models/follower_list_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/shared/loading.dart';
import 'package:feed_box/shared/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowerViewList extends StatefulWidget {
  @override
  _FollowerViewListState createState() => _FollowerViewListState();
}

class _FollowerViewListState extends State<FollowerViewList> {
  @override
  Widget build(BuildContext context) {
    final followerList = Provider.of<List<FollowerListModel>>(context);
    final user = Provider.of<UserModel>(context);

    return followerList.length == 0
        ? Loading()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: followerList.length,
            itemBuilder: (context, index) {
              if (user.uid != followerList[index].friendUid) {
                return Container(
                  padding: const EdgeInsets.only(top: 5,bottom: 5),
                  child: ListTile(
                      leading: Container(
                          width: 50,
                          height: 50,
                          child: ProfileHeader(
                              profile: followerList[index].friendUid)),
                      title: ProfileHeader(
                        profile: followerList[index].friendUid,
                        type: 'title',
                      )),
                );
              } else {
                return SizedBox();
              }
            },
          );
  }
}
