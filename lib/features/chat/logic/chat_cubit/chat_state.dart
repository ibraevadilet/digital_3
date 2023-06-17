part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.loading() = _Loading;
  const factory ChatState.error(String error) = _Error;
  const factory ChatState.success(List<MessageModel> model) = _Success;
}
