import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_box/models/profile.dart';

class ProfileService {
  final String uid;

  ProfileService({this.uid});

  final CollectionReference profileCollection =
      Firestore.instance.collection('profile');

  Future updateProfile(String fullname) async {
    return await profileCollection.document(uid).setData({'uid':uid,'fullname': fullname});
  }

  Profile _profileData(DocumentSnapshot snapshot) {
    return Profile(uid: uid, fullname: snapshot.data['fullname']);
  }

  List<Profile> _profileList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Profile(fullname: doc.data['fullname']);
    }).toList();
  }

  Stream<Profile> get profileData {
    return profileCollection.document(uid).snapshots().map(_profileData);
  }

  Stream<List<Profile>> get allProfile {
    return profileCollection.snapshots().map(_profileList);
  }
}
