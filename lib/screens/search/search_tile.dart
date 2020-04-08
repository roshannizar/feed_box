import 'package:feed_box/models/activity_model.dart';
import 'package:feed_box/models/follower_list_model.dart';
import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTile extends StatefulWidget {
  final ProfileModel profile;
  SearchTile({this.profile});

  @override
  _SearchTileState createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  bool following = false;
  String followerId;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final followerList = Provider.of<List<FollowerListModel>>(context) ?? [];

    followerList.forEach((f) {
      if (f.friendUid == widget.profile.uid) {
        following = true;
        followerId = f.friendUid;
      }
    });
    return Container(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('${widget.profile.profileUrl}'),
          ),
          title: Text('${widget.profile.fullname}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('@${widget.profile.email}'),
          trailing: FlatButton.icon(
              color: following ? Colors.white : Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () async {
                await ProfileService(uid: user.uid).newFollowing(
                    FollowerListModel(friendUid: widget.profile.uid),
                    following);

                if (following) {
                  await ProfileService(uid: user.uid).newActivity(ActivityModel(
                      titleDirection: false,
                      receiverUid: widget.profile.uid,
                      title: 'You started following'));

                  await ProfileService(uid: widget.profile.uid).newActivity(
                      ActivityModel(
                          titleDirection: true,
                          receiverUid: user.uid,
                          title: 'started following you'));
                } else {
                  await ProfileService(uid: user.uid).newActivity(ActivityModel(
                      titleDirection: false,
                      receiverUid: widget.profile.uid,
                      title: 'You unfollowed'));

                  await ProfileService(uid: widget.profile.uid).newActivity(
                      ActivityModel(
                          titleDirection: true,
                          receiverUid: user.uid,
                          title: 'started unfollowed you'));
                }

                setState(() {
                  following = !following;
                });
              },
              icon: Icon(following ? Icons.check : Icons.add,
                  color: following ? Colors.blue : Colors.white),
              label: Text(following ? 'Following' : 'Follow',
                  style: TextStyle(
                      color: following ? Colors.blue : Colors.white))),
        ),
      ),
    );
  }
}
