class ChatMessage {
  final String id;
  final String message;
  final String senderId;
  final String senderName;
  final String senderPhoto;
  final DateTime time;

  const ChatMessage({
    required this.id,
    required this.message,
    required this.senderId,
    required this.senderName,
    required this.senderPhoto,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'message': message});
    result.addAll({'senderId': senderId});
    result.addAll({'senderName': senderName});
    result.addAll({'senderPhoto': senderPhoto});
    result.addAll({'time': time.millisecondsSinceEpoch});
  
    return result;
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      message: map['message'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      senderPhoto: map['senderPhoto'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }
}
