import 'package:chat_app/core/services/firestore_services.dart';
import 'package:chat_app/core/utils/api_path.dart';
import 'package:chat_app/features/chat/models/chat_message.dart';

class ChatServices {
  final firestoreService = FirestoreService.instance;

  Future<void> sendMessage(ChatMessage message) async =>
      await firestoreService.setData(
        path: ApiPath.sendMessage(message.id),
        data: message.toMap(),
      );

  Stream<List<ChatMessage>> getMessages() => firestoreService.collectionStream(
        path: ApiPath.messages(),
        builder: (data, documentId) => ChatMessage.fromMap(data),
      );
}
