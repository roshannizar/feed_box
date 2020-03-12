import 'package:feed_box/models/profile.dart';
import 'package:feed_box/models/user.dart';
import 'package:feed_box/services/profile.dart';
import 'package:feed_box/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:feed_box/shared/constant.dart';
import 'package:provider/provider.dart';
import 'package:feed_box/services/post.dart';

class BottomPanel extends StatefulWidget {
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  final _formkey = GlobalKey<FormState>();

  bool isProgress = false;
  String fullname = '';
  String description;
  String date = '2020/03/04';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<Profile>(
        stream: ProfileService(uid: user.uid).profileData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            Profile profileData = snapshot.data;

            return SafeArea(
              child: Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'New Post',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    isProgress = true;
                                    fullname = profileData.fullname;
                                  });
                                  await PostService(uid: user.uid)
                                      .newPost(fullname, description, date);

                                  setState(() {
                                    isProgress = false;
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              color: Colors.blueAccent,
                              icon: Icon(Icons.done),
                            )),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  isProgress
                      ? LinearProgressIndicator(value: null)
                      : SizedBox(
                          height: 0,
                        ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                child: Text('RS'),
                              ),
                              title: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: TextFormField(
                                  onChanged: (val) =>
                                      setState(() => description = val),
                                  validator: (val) => val.isEmpty
                                      ? 'Share something, field is blank'
                                      : null,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Share your thoughts...'),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              )),
            );
          }
        });
  }
}
