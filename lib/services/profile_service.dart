import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_box/models/activity_model.dart';
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
    return await profileCollection.document(uid).setData({
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'profileUrl': profileUrl
    }).catchError((e) {
      print(e);
    });
  }

  Future newActivity(ActivityModel activityModel) async {
    return await profileCollection.document(uid).collection('activity').add({
      'uid': uid,
      'receiverUid': activityModel.receiverUid,
      'date':
          '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().toString().padLeft(2, '0')} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
      'title': activityModel.title
    }).catchError((e) {
      print(e);
    });
  }

  ProfileModel _profileData(DocumentSnapshot snapshot) {
    return ProfileModel(
        uid: uid,
        fullname: snapshot.data['fullname'],
        email: snapshot.data['email'],
        profileUrl: snapshot.data['profileUrl']);
  }

  List<ActivityModel> _activityList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ActivityModel(
          uid: doc.data['uid'],
          date: doc.data['date'],
          receiverUid: doc.data['receiverUid'],
          title: doc.data['title']);
    }).toList();
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

  Stream<List<ActivityModel>> get allActivity {
    return profileCollection
        .document(uid)
        .collection('activity')
        .snapshots()
        .map(_activityList);
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
