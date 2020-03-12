import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  final String uid;
  final CollectionReference messagesCollection = Firestore.instance.collection('messages');

  MessageService({this.uid});


}