part of 'chat_cubit.dart';

enum ChatStateStatus { initial, loading, success }

class ChatState {
  final ChatStateStatus status;
  final List<ChatEntity> chats;

  const ChatState({
    required this.chats,
    this.status = ChatStateStatus.initial,
  });
}
