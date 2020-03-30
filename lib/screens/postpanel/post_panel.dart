import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/screens/postpanel/my_post.dart';
import 'package:feed_box/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:feed_box/screens/postpanel/bottom_panel.dart';
import 'package:provider/provider.dart';

class PostPanel extends StatefulWidget {
  @override
  _PostPanelState createState() => _PostPanelState();
}

class _PostPanelState extends State<PostPanel> {
  void _showPostPanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.963,
            child: BottomPanel(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamProvider<List<PostModel>>.value(
        value: PostService(uid: user.uid).myPosts,
        child: Scaffold(
            appBar: AppBar(
              title: Text('My Post'),
              backgroundColor: Colors.blueAccent,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    _showPostPanel();
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            body: MyPost()));
  }
}
