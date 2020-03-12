import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_box/models/post.dart';

class PostService {
  final String uid;
  final CollectionReference postCollection =
      Firestore.instance.collection('post');

  PostService({this.uid});

  //new post
  Future newPost(String fullname, String description, String date) async {
    return await postCollection
        .add({'uid':uid,'fullname': fullname,'description': description, 'date': date});
  }

  List<Post> _postsListCollection(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {

      return Post(
        fullname: doc.data['fullname'] ?? '',
        description: doc.data['description'] ?? '',
        date: doc.data['date'] ?? ''
      );
    }).toList();
  }

  List<Post> _userPost(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {

      return Post(
        fullname: doc.data['fullname'] ?? '',
        description: doc.data['description'] ?? '',
        date: doc.data['date'] ?? ''
      );
    }).toList();
  }

  Stream<List<Post>> get posts {
    return postCollection.snapshots().map(_postsListCollection);
  }

  Stream<List<Post>> get myPosts {
    return postCollection.where('uid',isEqualTo:uid).snapshots().map(_userPost);
  }
}
