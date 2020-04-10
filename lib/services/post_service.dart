import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_box/models/activity_model.dart';
import 'package:feed_box/models/comments_model.dart';
import 'package:feed_box/models/like_model.dart';
import 'package:feed_box/models/post_model.dart';
import 'package:feed_box/services/profile_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class PostService {
  final String uid;
  final CollectionReference postCollection =
      Firestore.instance.collection('post');
  final CollectionReference profileCollection =
      Firestore.instance.collection('profile');
  final StorageReference firebaseStorage =
      FirebaseStorage.instance.ref().child('post');

  PostService({this.uid});

  //new post
  Future newPost(
      String fullname, String description, File image, File video) async {
    String formattedDate = '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')} ${DateTime.now().hour.toString().padLeft(2,'0')}:${DateTime.now().minute.toString().padLeft(2,'0')}';//eg 2020-04-09 16.00

    // checks whether iamge and video is null, if not post is added without any url firebase storage will be blocked
    if (video == null && image == null) { 
      return await postCollection.add({
        'uid': uid,
        'fullname': fullname,
        'description': description,
        'date': formattedDate
      }).catchError((e) {
        print(e);
      });
    } else {

      //this upload image and video to firebasestorage
      StorageUploadTask task = firebaseStorage
          .child(formattedDate)
          .putFile(video ?? image, StorageMetadata(contentType: 'video.mp4'));

      await (task.onComplete).then((s) async {
        String url = await s.ref.getDownloadURL();//once upload is done url can be extracted
        return await postCollection.add({
          'uid': uid,
          'fullname': fullname,
          'description': description,
          'date': formattedDate,
          'postUrl': url, //main firebase storage link 
          'video': video.toString(),//path is stored
          'image': image.toString() // path is stored
        }).catchError((e) {
          print(e);
        });
      });
    }
  }

  //like method
  Future newLike(String profile, String docid, String likedocid, bool liked,
      String ruid) async {
    if (liked) {//check whether the post is already liked
      await postCollection
          .document(docid)
          .collection('likes')
          .document(likedocid)
          .delete()
          .catchError((e) {
        return e;
      });
    } else {
      await postCollection
          .document(docid)
          .collection('likes')
          .add({'profile': profile}).catchError((e) {
        return e;
      });

      if (ruid != null) { //activity will be tracked when receiver id is null 
        await ProfileService(uid: ruid).newActivity(ActivityModel(
            titleDirection: true,
            title: 'liked your post',
            receiverUid: profile));
      }
    }
  }

  //comments method
  Future newComments(String content, String profile, String docid) async {
    return await postCollection
        .document(docid)
        .collection('comments')
        .add({'profile': profile, 'content': content}).catchError((e) {
      print(e);
    });
  }

  //delete psot method
  Future deletePost(String docid) async {
    return await postCollection.document(docid).delete().catchError((e) {
      print(e);
    });
  }
  
  //post list mapping model method
  List<PostModel> _postsListCollection(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PostModel(
          fullname: doc.data['fullname'] ?? '',
          description: doc.data['description'] ?? '',
          date: doc.data['date'] ?? '',
          postUrl: doc.data['postUrl'] ?? '',
          uid: doc.data['uid'] ?? '',
          video: doc.data['video'] ?? '',
          image: doc.data['image'] ?? '',
          documentId: doc.documentID ?? '');
    }).toList();
  }

  //user list mapping model method
  List<PostModel> _userPost(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PostModel(
          fullname: doc.data['fullname'] ?? '',
          description: doc.data['description'] ?? '',
          date: doc.data['date'] ?? '',
          postUrl: doc.data['postUrl'] ?? '',
          uid: doc.data['uid'] ?? '',
          video: doc.data['video'] ?? '',
          image: doc.data['image'] ?? '',
          documentId: doc.documentID ?? '');
    }).toList();
  }

  //likes mapping model method
  List<LikeModel> _likes(QuerySnapshot snapshot) {
    return snapshot.documents.map((f) {
      return LikeModel(
          profile: f.data['profile'] ?? '', likedocid: f.documentID ?? '');
    }).toList();
  }

  //comments list mapping model method
  List<CommentModel> _comments(QuerySnapshot snapshot) {
    return snapshot.documents.map((f) {
      return CommentModel(
          profile: f.data['profile'] ?? '', content: f.data['content'] ?? '');
    }).toList();
  }

  //stream method to listen all the post collection
  Stream<List<PostModel>> get posts {
    return postCollection
        .orderBy('date', descending: true)
        .snapshots()
        .map(_postsListCollection);
  }

  //stream method to listen all the likes collection
  Stream<List<LikeModel>> get likes {
    return postCollection
        .document(uid)
        .collection('likes')
        .snapshots()
        .map(_likes);
  }

  //stream method to listen all the comment collection
  Stream<List<CommentModel>> get getComments {
    return postCollection
        .document(uid)
        .collection('comments')
        .snapshots()
        .map(_comments);
  }

  //stream method to listen all the my post collection
  Stream<List<PostModel>> get myPosts {
    return postCollection
        .where('uid', isEqualTo: uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map(_userPost);
  }
}
