import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/screens/postpanel/my_post.dart';
import 'package:feed_box/services/post_service.dart';
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
                FlatButton(onPressed: () {}, child: Text('Followers 2')),
                FlatButton(onPressed: () {}, child: Text('Following 4')),
              ],
            ),
            body: MyPost()));
  }
}
