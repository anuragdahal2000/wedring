import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedring/models/chat.dart';
import 'package:wedring/models/message.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/models/user.dart' as u;

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

  void startConversation(String recieverId, Message message,
      BuildContext context, u.User chatUser) async {
    _firestore
        .collection('chat')
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
        _firestore.collection('chat').doc(value.id).update({
          'id': value.id,
        });
        sendMessage(message.text, value.id, message.senderId);
        context.goNamed(
          'single-chat',
          pathParameters: {'chatId': value.id},
          extra: chatUser,
        );
      },
    );
  }
}
