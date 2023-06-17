import 'package:digital_3/features/chat/logic/chat_repo.dart';
import 'package:digital_3/features/chat/logic/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.repo) : super(const ChatState.loading());

  final GetMessagesRepo repo;

  getChats(String chatId) {
    try {
      repo.getMessages(chatId).listen((data) {
        emit(ChatState.success(List.from(data.reversed)));
      });
    } catch (e) {
      emit(ChatState.error(e.toString()));
    }
  }

  sendMessage(MessageModel model) async {
    await repo.sendMessge(model);
  }

  deleteMessage(String chatId, String messageId) async {
    await repo.deleteMessge(chatId, messageId);
  }
}
