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
  bool change = false;
  String fullname = '';
  String description;
  File image, video;

  Future getVideo() async {
    var holdVideo = await ImagePicker.pickVideo(source: ImageSource.gallery);

    setState(() {
      video = holdVideo;
      image = null;
    });
  }

  Future getImage() async {
    var holdImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = holdImage;
      video = null;
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

            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                title: Text('New Post', style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.white,
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        setState(() {
                          isProgress = true;
                          fullname = profileData.fullname;
                        });
                        await PostService(uid: user.uid)
                            .newPost(fullname, description, image, video);

                        setState(() {
                          isProgress = false;
                        });
                        Navigator.pop(context);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    color: change ? Colors.blueAccent : Colors.grey,
                    label: Text('Post', style: TextStyle(color: Colors.white)),
                    icon: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              body: ListView(children: <Widget>[
                Container(
                    child: Column(
                  children: <Widget>[
                    isProgress
                        ? LinearProgressIndicator(value: null)
                        : SizedBox(
                            height: 0,
                          ),
                    Container(
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
                                    onChanged: (val) {
                                      setState(() {
                                        description = val;
                                        change = true;
                                      });
                                    },
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
                        )),
                    image != null
                        ? Container(
                            child: Image.file(image),
                          )
                        : Container()
                  ],
                )),
              ]),
            );
          }
        });
  }
}
