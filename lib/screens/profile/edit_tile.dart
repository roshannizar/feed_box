import 'dart:io';

import 'package:feed_box/models/profile_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:feed_box/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditTile extends StatefulWidget {
  @override
  _EditTileState createState() => _EditTileState();
}

class _EditTileState extends State<EditTile> {
  String fullname, email, image, bio, contact;
  final _formkey = GlobalKey<FormState>();
  File imageUrl;
  bool loading = false;
  bool change = false;
  bool exist = true;

  Future getImage() async {
    var holdImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageUrl = holdImage;
      exist = false;
      change = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return loading
        ? Loading()
        : StreamBuilder<ProfileModel>(
            stream: ProfileService(uid: user.uid).profileData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (change == false) {
                  ProfileModel profile = snapshot.data;
                  fullname = profile.fullname;
                  email = profile.email;
                  image = profile.profileUrl;
                  bio = profile.bio;
                  contact = profile.contact;
                }

                return Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: imageUrl == null
                            ? NetworkImage(image)
                            : FileImage(imageUrl),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await getImage();
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        initialValue: fullname,
                        onChanged: (val) {
                          setState(() {
                            change = true;
                            fullname = val;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.mail),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        initialValue: email,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Bio',
                          prefixIcon: Icon(Icons.info),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        maxLines: 5,
                        initialValue: bio,
                        onChanged: (val) {
                          setState(() {
                            change = true;
                            bio = val;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Contact',
                          prefixIcon: Icon(Icons.contact_phone),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        initialValue: contact,
                        keyboardType: TextInputType.phone,
                        onChanged: (val) {
                          setState(() {
                            contact = val;
                            change = true;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });

                              await ProfileService(uid: user.uid).updateProfile(
                                  fullname,
                                  email,
                                  bio,
                                  contact,
                                  imageUrl,
                                  snapshot.data.profileUrl);
                              setState(() {
                                loading = false;
                              });
                              Navigator.pop(context);
                            } else {
                              print('vola');
                            }
                          },
                          color: change ? Colors.blue : Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('Save Changes',
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Loading();
              }
            });
  }
}
