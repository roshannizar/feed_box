/**
 * Profile service class
 */

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_box/models/activity_model.dart';
import 'package:feed_box/models/follower_list_model.dart';
import 'package:feed_box/models/profile_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileService {
  final String uid;

  //default profile image
  String profileUrl =
      'https://firebasestorage.googleapis.com/v0/b/feed-box-c1336.appspot.com/o/profile%2Fblank-profile-picture-973460_640.png?alt=media&token=35274574-be73-4e51-a0c4-49ab435803d5';
  ProfileService({this.uid});
  final StorageReference firebaseStorage =
      FirebaseStorage.instance.ref().child('profile');
  final CollectionReference profileCollection =
      Firestore.instance.collection('profile');

  //update profile
  Future updateProfile(String fullname, String email, String bio,
      String contact, File imageUrl, String url) async {
    if (imageUrl != null) {
      StorageUploadTask task =
          firebaseStorage.child(DateTime.now().toString()).putFile(imageUrl);

      await (task.onComplete).then((s) async {
        url = await s.ref
            .getDownloadURL(); //once upload is done url can be extracted
      });
    }

    await profileCollection.document(uid).setData({
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'profileUrl': url == null ? profileUrl : url,
      'bio': bio,
      'contact': contact
    }).catchError((e) {
      print(e);
    });

    if (url == null) {
      //add a default following method to get all your personal post,
      //where your uid will be stored and will be easy to retreive the post
      await profileCollection.document(uid).collection('following').add(
          {'friendName': 'Roshan Nizar', 'friendUid': uid}).catchError((e) {
        print(e);
      });
    }
  }

  //activity tracking method
  Future newActivity(ActivityModel activityModel) async {
    return await profileCollection.document(uid).collection('activity').add({
      'uid': uid,
      'titleDirection': activityModel.titleDirection,
      'receiverUid': activityModel.receiverUid,
      'date':
          '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}', //eg: 2020-04-09 16.00
      'title': activityModel.title
    }).catchError((e) {
      print(e);
    });
  }

  //new follwing method
  Future newFollowing(
      FollowerListModel followerListModel, bool following) async {
    if (following) {
      //check already following

      //update my profile following
      await profileCollection
          .document(uid)
          .collection('following')
          .document(followerListModel.friendUid)
          .delete()
          .catchError((e) {
        print(e);
      });

      //update friend profile followers
      await profileCollection
          .document(followerListModel.friendUid)
          .collection('followers')
          .document(uid)
          .delete()
          .catchError((e) {
        print(e);
      });
    } else {
      //update my profile following
      await profileCollection
          .document(uid)
          .collection('following')
          .document(followerListModel.friendUid)
          .setData({
        'friendName': followerListModel.friendName,
        'friendUid': followerListModel.friendUid
      }).catchError((e) {
        print(e);
      });

      //update friend profile followers
      await profileCollection
          .document(followerListModel.friendUid)
          .collection('followers')
          .document(uid)
          .setData(
              {'friendName': followerListModel.friendName, 'friendUid': uid});
    }
  }

  //profile data mapping model
  ProfileModel _profileData(DocumentSnapshot snapshot) {
    return ProfileModel(
        uid: uid,
        fullname: snapshot.data['fullname'],
        email: snapshot.data['email'],
        profileUrl: snapshot.data['profileUrl'],
        bio: snapshot.data['bio'],
        contact: snapshot.data['contact']);
  }

  //activity list mapping model
  List<ActivityModel> _activityList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ActivityModel(
          uid: doc.data['uid'],
          date: doc.data['date'],
          receiverUid: doc.data['receiverUid'],
          titleDirection: doc.data['titleDirection'],
          title: doc.data['title']);
    }).toList();
  }

  //profile list mapping model
  List<ProfileModel> _profileList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ProfileModel(
          fullname: doc.data['fullname'] ?? '',
          uid: doc.data['uid'] ?? '',
          email: doc.data['email'] ?? '',
          profileUrl: doc.data['profileUrl'] ?? '',
          bio: doc.data['bio'] ?? '',
          contact: doc.data['contact'] ?? '');
    }).toList();
  }

  //follower list mapping model
  List<FollowerListModel> _follower(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return FollowerListModel(
          friendName: doc.data['friendName'],
          friendUid: doc.data['friendUid'],
          docid: doc.data['docid']);
    }).toList();
  }

  //following list mapping model
  List<FollowerListModel> _following(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return FollowerListModel(
          friendName: doc.data['friendName'],
          friendUid: doc.data['friendUid'],
          docid: doc.data['docid']);
    }).toList();
  }

  //stream method to retrieve Profile Model
  Stream<ProfileModel> get profileData {
    return profileCollection.document(uid).snapshots().map(_profileData);
  }

  //stream method to retrieve Activity list Model
  Stream<List<ActivityModel>> get allActivity {
    return profileCollection
        .document(uid)
        .collection('activity')
        .orderBy('date', descending: true)
        .snapshots()
        .map(_activityList);
  }

  //stream method to retrieve list profile model
  Stream<List<ProfileModel>> get allProfile {
    return profileCollection.snapshots().map(_profileList);
  }

  //stream method to retrieve follower list model
  Stream<List<FollowerListModel>> get getFollower {
    return profileCollection
        .document(uid)
        .collection('followers')
        .snapshots()
        .map(_follower);
  }

  //stream method to retrieve following list model
  Stream<List<FollowerListModel>> get getFollowing {
    return profileCollection
        .document(uid)
        .collection('following')
        .snapshots()
        .map(_following);
  }
}
