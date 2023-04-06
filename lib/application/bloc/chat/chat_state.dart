part of 'chat_cubit.dart';

enum ChatStateStatus { initial, loading, success }

class ChatState {
  final ChatStateStatus status;
  final List<CurrentChatState> chatStates;

  const ChatState({
    required this.chatStates,
    this.status = ChatStateStatus.initial,
  });
}
