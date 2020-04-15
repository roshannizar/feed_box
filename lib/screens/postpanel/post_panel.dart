import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/screens/postpanel/my_post.dart';
import 'package:feed_box/services/post_service.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:feed_box/shared/follower.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPanel extends StatefulWidget {
  @override
  _PostPanelState createState() => _PostPanelState();
}

class _PostPanelState extends State<PostPanel> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamProvider<List<PostModel>>.value(
        value: PostService(uid: user.uid).myPosts,
        child: Scaffold(
            appBar: AppBar(
              title: Text('My Post', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              actions: <Widget>[
                Follower(
                    streamFunction: ProfileService(uid: user.uid).getFollower,
                    type: 'Followers'),
                Follower(
                    streamFunction: ProfileService(uid: user.uid).getFollowing,
                    type: 'Following')
              ],
            ),
            body: MyPost()));
  }
}
