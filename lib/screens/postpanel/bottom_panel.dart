import 'dart:io';

import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/services/post_service.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:feed_box/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:feed_box/shared/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BottomPanel extends StatefulWidget {
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  final _formkey = GlobalKey<FormState>();

  bool isProgress = false;
  String fullname = '';
  String description;
  String image, video;
  File file;

  Future getVideo() async {
    var holdVideo = await ImagePicker.pickVideo(source: ImageSource.gallery);

    setState(() {
      file = holdVideo;
      video = 'done';
      image = null;
    });
  }

  Future getImage() async {
    var holdImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      file = holdImage;
      video = null;
      image = 'done';
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<ProfileModel>(
        stream: ProfileService(uid: user.uid).profileData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            ProfileModel profileData = snapshot.data;

            return SafeArea(
              child: Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'Feed Box',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 10),
                            child: FlatButton.icon(
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    isProgress = true;
                                    fullname = profileData.fullname;
                                  });
                                  await PostService(uid: user.uid)
                                      .newPost(fullname, description, file);

                                  setState(() {
                                    isProgress = false;
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Colors.blueAccent,
                              label: Text('Post',
                                  style: TextStyle(color: Colors.white)),
                              icon: Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
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
                                backgroundImage:
                                    NetworkImage('${profileData.profileUrl}'),
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
                                    fillColor: Colors.white,
                                      hintText: 'Share your thoughts...'),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
                                ),
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () async {
                                      await getImage();
                                    },
                                    icon: Icon(image == null
                                        ? Icons.perm_media
                                        : Icons.done),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await getVideo();
                                    },
                                    icon: Icon(video == null
                                        ? Icons.video_call
                                        : Icons.done),
                                  ),
                                ],
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
