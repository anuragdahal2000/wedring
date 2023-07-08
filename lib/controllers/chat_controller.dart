import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedring/models/chat.dart';
import 'package:wedring/models/message.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void sendMessage(String message, String chatId, String senderId) {
    _firestore.collection('chat').doc(chatId).set({
      "lastSentAt": DateTime.now(),
      "lastMessage": message,
      "messages": FieldValue.arrayUnion([
        Message(
          senderId: senderId,
          text: message,
          timestamp: DateTime.now(),
        ).toJson()
      ]),
    }, SetOptions(merge: true));
  }

  void startConversation(String recieverId, Message message) async {
    _firestore
        .collection('chats')
        .add(
          Chat(
            id: '',
            participantsId: [message.senderId, recieverId],
            lastMessage: message.text,
            lastSentAt: DateTime.now(),
          ).toJson(),
        )
        .then(
      (value) {
        _firestore.collection('chats').doc(value.id).set({
          'id': value.id,
        });
        sendMessage(message.text, value.id, message.senderId);
      },
    );
  }
}
