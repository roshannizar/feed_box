import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_box/models/follower_list_model.dart';
import 'package:feed_box/models/profile.dart';

class ProfileService {
  final String uid;
  String profileUid;

  ProfileService({this.uid});

  final CollectionReference profileCollection =
      Firestore.instance.collection('profile');

  Future updateProfile(String fullname, String email) async {
    try {
      return await profileCollection
          .document(uid)
          .setData({'uid': uid, 'fullname': fullname, 'email': email});
    } catch (e) {
      print(e);
    }
  }

  ProfileModel _profileData(DocumentSnapshot snapshot) {

    return ProfileModel(
        uid: uid,
        fullname: snapshot.data['fullname'],
        email: snapshot.data['email']);
  }

  List<ProfileModel> _profileList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ProfileModel(
          fullname: doc.data['fullname'],
          uid: doc.data['uid'],
          email: doc.data['email']);
    }).toList();
  }

  List<FollowerListModel> _follower(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return FollowerListModel(
          friendName: doc.data['friendName'],
          friendUid: doc.data['friendUid'],
          messageId: doc.data['messageId']);
    }).toList();
  }

  Stream<ProfileModel> get profileData {
    return profileCollection.document(uid).snapshots().map(_profileData);
  }

  Stream<List<ProfileModel>> get allProfile {
    return profileCollection.snapshots().map(_profileList);
  }

  Stream<List<FollowerListModel>> get getFollower {
    return profileCollection
        .document(profileUid)
        .collection('followers')
        .snapshots()
        .map(_follower);
  }
}
