import 'package:feed_box/models/comments_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/screens/feeds/comments/comments_container_list.dart';
import 'package:feed_box/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsContainer extends StatefulWidget {
  final String docid;
  CommentsContainer({this.docid});
  @override
  _CommentsContainerState createState() => _CommentsContainerState();
}

class _CommentsContainerState extends State<CommentsContainer> {
  String commentText;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamProvider<List<CommentModel>>.value(
      value: PostService(uid: widget.docid).getComments,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text('Nawzath Post')),
            Divider(),
            Container(
              padding: const EdgeInsets.all(10),
              child: CommentsContainerList(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    commentText = value;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          await PostService()
                              .newComments(commentText, user.uid, widget.docid);
                          setState(() {
                            commentText = '';
                          });
                        },
                        icon: Icon(Icons.send)),
                    hintText: 'Enter comments here ...'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
