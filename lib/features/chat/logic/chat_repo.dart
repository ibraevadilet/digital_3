import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_3/features/chat/logic/message_model.dart';

abstract class GetMessagesRepo {
  Stream<List<MessageModel>> getMessages(String messagesListId);
  Future<void> sendMessge(MessageModel model);
  Future<void> deleteMessge(String chatId, String messageId);
}

class GetMessagesRepoImpl implements GetMessagesRepo {
  GetMessagesRepoImpl();
  @override
  Stream<List<MessageModel>> getMessages(String messagesListId) async* {
    final controller = StreamController<List<MessageModel>>();

    CollectionReference firestore = FirebaseFirestore.instance
        .collection('messagesList')
        .doc(messagesListId)
        .collection('messages');
    try {
      final messagesList = firestore.snapshots();

      messagesList.listen((e) async {
        List<MessageModel> messages = [];

        for (var e in e.docs) {
          messages.add(MessageModel.fromQwerySnapshot(e));
        }
        controller.add(messages);
      });

      yield* controller.stream;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> sendMessge(MessageModel model) async {
    CollectionReference firestore = FirebaseFirestore.instance
        .collection('messagesList')
        .doc(model.chatId)
        .collection('messages');

    firestore.doc(model.messageId.toString()).set(model.toJson());
  }

  @override
  Future<void> deleteMessge(String chatId, String messageId) async {
    DocumentReference firestore = FirebaseFirestore.instance
        .collection('messagesList')
        .doc(chatId)
        .collection('messages')
        .doc(messageId);

    firestore.delete();
  }
}
