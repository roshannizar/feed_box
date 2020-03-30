import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_box/models/chat_model.dart';

class MessageService {
  final String uid;
  final String to;
  final String fromUid;
  final CollectionReference messagesCollection =
      Firestore.instance.collection('messages');

  MessageService({this.uid, this.to, this.fromUid});

  //send message
  Future sendMessage(String from, String to, String content) async {
    return Firestore.instance.runTransaction((transaction) async {
      try {
        await transaction.set(
            messagesCollection
                .document(uid)
                .collection(to)
                .document(DateTime.now().millisecondsSinceEpoch.toString()),
            {
              'from': from,
              'to': to,
              'content': content,
              'date': DateTime.now().millisecondsSinceEpoch.toString()
            });
      } catch (e) {
        print(e);
      }
    });
  }

  List<ChatModel> _chat(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ChatModel(
          to: doc.data['to'] ?? '',
          from: doc.data['from'] ?? '',
          date: doc.data['date'] ?? '',
          content: doc.data['content'] ?? '');
    }).toList();
  }

  Stream<List<ChatModel>> get myChat {
    if (messagesCollection.document(uid).collection(to).snapshots().isEmpty !=null) {
      print(fromUid);
      return messagesCollection
          .document(fromUid)
          .collection(to)
          .snapshots()
          .map(_chat);
    } else {
      return messagesCollection
          .document(uid)
          .collection(to)
          .snapshots()
          .map(_chat);
    }
  }
}