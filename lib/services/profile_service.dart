import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_box/models/follower_list_model.dart';
import 'package:feed_box/models/profile_model.dart';

class ProfileService {
  final String uid;
  String profileUid;
  String profileUrl =
      'https://firebasestorage.googleapis.com/v0/b/feed-box-c1336.appspot.com/o/profile%2Fblank-profile-picture-973460_640.png?alt=media&token=35274574-be73-4e51-a0c4-49ab435803d5';

  ProfileService({this.uid});

  final CollectionReference profileCollection =
      Firestore.instance.collection('profile');

  Future updateProfile(String fullname, String email) async {
    try {
      return await profileCollection.document(uid).setData({
        'uid': uid,
        'fullname': fullname,
        'email': email,
        'profileUrl': profileUrl
      });
    } catch (e) {
      print(e);
    }
  }

  ProfileModel _profileData(DocumentSnapshot snapshot) {
    return ProfileModel(
        uid: uid,
        fullname: snapshot.data['fullname'],
        email: snapshot.data['email'],
        profileUrl: snapshot.data['profileUrl']);
  }

  List<ProfileModel> _profileList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ProfileModel(
          fullname: doc.data['fullname'],
          uid: doc.data['uid'],
          email: doc.data['email'],
          profileUrl: doc.data['profileUrl']);
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

  List<FollowerListModel> _following(QuerySnapshot snapshot) {
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

  Stream<List<FollowerListModel>> get getFollowing {
    return profileCollection
        .document(profileUid)
        .collection('following')
        .snapshots()
        .map(_following);
  }
}
