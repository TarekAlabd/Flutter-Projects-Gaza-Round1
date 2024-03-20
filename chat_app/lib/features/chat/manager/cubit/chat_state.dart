part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class MessageSent extends ChatState {}

final class SendingMessage extends ChatState {}

final class SendingError extends ChatState {
  final String message;

  SendingError(this.message);
}

final class ChatSuccess extends ChatState {
  final List<ChatMessage> messages;
  final String currentUserId;

  ChatSuccess(this.messages, this.currentUserId);
}

final class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
