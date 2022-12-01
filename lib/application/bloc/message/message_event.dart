part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class MessageRequestEvent extends MessageEvent {}
