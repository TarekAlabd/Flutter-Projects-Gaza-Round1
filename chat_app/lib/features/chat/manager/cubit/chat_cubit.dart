import 'package:chat_app/core/services/user_services.dart';
import 'package:chat_app/features/chat/services/chat_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/chat/models/chat_message.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final chatServices = ChatServices();
  final userServices = UserServices();

  Future<void> sendMessage(String message) async {
    emit(SendingMessage());
    try {
      final currentUser = await userServices.getUser();

      final chatMessage = ChatMessage(
        id: DateTime.now().toIso8601String(),
        message: message,
        senderId: currentUser.id,
        senderName: currentUser.username,
        senderPhoto: currentUser.photoUrl,
        time: DateTime.now(),
      );

      await chatServices.sendMessage(chatMessage);
      emit(MessageSent());
    } catch (e) {
      emit(SendingError(e.toString()));
    }
  }

  Future<void> getMessages() async {
    emit(ChatLoading());
    try {
      final currentUser = await userServices.getUser();
      final messagesStream = chatServices.getMessages();
      messagesStream.listen((messages) {
        emit(ChatSuccess(messages, currentUser.id));
      });
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
