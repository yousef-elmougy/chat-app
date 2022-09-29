
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_model.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendMessage(
      {String? text, receiverId, senderId, DateTime? dateTime});

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      {String? receiverId, senderId});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<void> sendMessage(
      {String? text,
      receiverId,
      senderId,
      DateTime? dateTime}) async {
    ChatModel chatModel = ChatModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: senderId,
    );

    // ADD MY CHAT
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('features.chat')
        .doc(receiverId)
        .collection('messages')
        .add(chatModel.toJson());

    // ADD RECEIVER CHAT
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('features.chat')
        .doc(senderId)
        .collection('messages')
        .add(chatModel.toJson());
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
          {String? receiverId, senderId}) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('features.chat')
          .doc(receiverId)
          .collection('messages')
          .orderBy('dateTime')
          .snapshots(includeMetadataChanges: true);
}
