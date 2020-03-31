import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_box/models/comments_model.dart';
import 'package:feed_box/models/like_model.dart';
import 'package:feed_box/models/post_model.dart';

class PostService {
  final String uid;
  final CollectionReference postCollection =
      Firestore.instance.collection('post');

  PostService({this.uid});

  //new post
  Future newPost(String fullname, String description, String date) async {
    return await postCollection.add({
      'uid': uid,
      'fullname': fullname,
      'description': description,
      'date': date
    }).catchError((e) {
      print(e);
    });
  }

  Future newLike(
      String profile, String docid, String likedocid, bool liked) async {
    if (liked) {
      return await postCollection
          .document(docid)
          .collection('likes')
          .document(likedocid)
          .delete()
          .catchError((e) {
        print(e);
      });
    } else {
      return await postCollection
          .document(docid)
          .collection('likes')
          .add({'profile': profile}).catchError((e) {
        print(e);
      });
    }
  }

  List<PostModel> _postsListCollection(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PostModel(
          fullname: doc.data['fullname'] ?? '',
          description: doc.data['description'] ?? '',
          date: doc.data['date'] ?? '',
          postUrl: doc.data['postUrl'] ?? '',
          uid: doc.data['uid'] ?? '',
          documentId: doc.documentID ?? '');
    }).toList();
  }

  List<PostModel> _userPost(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PostModel(
          fullname: doc.data['fullname'] ?? '',
          description: doc.data['description'] ?? '',
          date: doc.data['date'] ?? '',
          postUrl: doc.data['postUrl'] ?? '',
          uid: doc.data['uid'] ?? '');
    }).toList();
  }

  List<LikeModel> _likes(QuerySnapshot snapshot) {
    return snapshot.documents.map((f) {
      return LikeModel(
          profile: f.data['profile'] ?? '', likedocid: f.documentID ?? '');
    }).toList();
  }

  List<CommentModel> _comments(QuerySnapshot snapshot) {
    return snapshot.documents.map((f) {
      return CommentModel(
          profile: f.data['profile'] ?? '', content: f.data['comments'] ?? '');
    }).toList();
  }

  Stream<List<PostModel>> get posts {
    return postCollection.snapshots().map(_postsListCollection);
  }

  Stream<List<LikeModel>> get likes {
    return postCollection
        .document(uid)
        .collection('likes')
        .snapshots()
        .map(_likes);
  }

  Stream<List<CommentModel>> get getComments {
    return postCollection
        .document(uid)
        .collection('comments')
        .snapshots()
        .map(_comments);
  }

  Stream<List<PostModel>> get myPosts {
    return postCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_userPost);
  }
}
