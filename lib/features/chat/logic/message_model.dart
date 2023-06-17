// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String userName;
  final String chatId;
  final int messageId;
  final String userId;
  final String date;
  MessageModel({
    required this.message,
    required this.userName,
    required this.chatId,
    required this.messageId,
    required this.userId,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'userName': userName,
      'chatId': chatId,
      'messageId': messageId,
      'userId': userId,
      'date': date,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      userName: map['userName'] as String,
      chatId: map['chatId'] as String,
      messageId: map['messageId'] as int,
      userId: map['userId'] as String,
      date: map['date'] as String,
    );
  }
  factory MessageModel.fromQwerySnapshot(QueryDocumentSnapshot map) {
    return MessageModel(
      message: map['message'] as String,
      userName: map['userName'] as String,
      chatId: map['chatId'] as String,
      messageId: map['messageId'] as int,
      userId: map['userId'] as String,
      date: map['date'] as String,
    );
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.userName == userName &&
        other.chatId == chatId &&
        other.messageId == messageId &&
        other.userId == userId &&
        other.date == date;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        userName.hashCode ^
        chatId.hashCode ^
        messageId.hashCode ^
        userId.hashCode ^
        date.hashCode;
  }
}
