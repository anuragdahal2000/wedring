import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/controllers/chat_controller.dart';
import 'package:wedring/models/chat.dart';
import 'package:wedring/models/message.dart';
import 'package:wedring/utils/constant.dart';

import '../../components/reveiver_row_view.dart';
import '../../components/sender_row.view.dart';
import 'package:wedring/models/user.dart' as user;

class SingleChat extends StatefulWidget {
  final String chatId;
  final user.User participant;
  final bool isNewChat;

  const SingleChat({
    super.key,
    required this.chatId,
    required this.participant,
    this.isNewChat = false,
  });

  @override
  SingleChatState createState() => SingleChatState();
}

class SingleChatState extends State<SingleChat> {
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var message = '';
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // void sendMessage(String message, String chatId, String userId) {
  //   _firestore.collection('chat').doc(chatId).set({
  //     "lastSentAt": DateTime.now(),
  //     "lastMessage": message,
  //     "messages": FieldValue.arrayUnion([
  //       Message(
  //         senderId: userId,
  //         text: message,
  //         timestamp: DateTime.now(),
  //       ).toJson()
  //     ]),
  //   }, SetOptions(merge: true));
  // }
  final ChatController chatController = ChatController();

  void animateList() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.offset !=
          scrollController.position.maxScrollExtent) {
        animateList();
      }
    });
  }

  // List<ChatModel> chatModelList = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.goNamed('chat');
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        titleSpacing: 0,
        title: ListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://picsum.photos/250?image=9',
            ),
          ),
          title: Text(
            widget.participant.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            'online',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.videocam_rounded),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.call),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Builder(
              builder: (context) {
                if (widget.isNewChat) {
                  return const Text('Start a new chat');
                } else {
                  return StreamBuilder<Chat>(
                    stream: FirebaseFirestore.instance
                        .collection('chat')
                        .doc(widget.chatId)
                        .snapshots()
                        .map((event) {
                      return Chat.fromJson(event.data()!);
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final chatModelList = snapshot.data!.messages;
                        return Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: ListView.builder(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: chatModelList.length,
                            itemBuilder: (context, index) {
                              final message = chatModelList[index];
                              if (chatModelList.isEmpty) {
                                return const Center(
                                  child: Text('No Messages'),
                                );
                              } else {
                                return chatModelList
                                            .elementAt(index)
                                            .senderId !=
                                        widget.participant.uid
                                    ? SenderRowView(
                                        message: message,
                                      )
                                    : ReceiverRowView(message: message);
                              }
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                }
              },
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0, left: 8),
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      color: kPrimaryColor1,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: 6,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      controller: controller,
                      onFieldSubmitted: (value) {
                        controller.text = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                        hintText: 'Type a message',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12, right: 10),
                    child: Transform.rotate(
                      angle: 45,
                      child: const Icon(
                        Icons.attachment_outlined,
                        color: kPrimaryColor1,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.isNewChat) {
                        chatController.startConversation(
                          widget.participant.uid,
                          Message(
                            senderId: auth.currentUser!.uid,
                            text: controller.text,
                            timestamp: DateTime.now(),
                          ),
                        );
                      } else {
                        chatController.sendMessage(
                          controller.text,
                          widget.chatId,
                          auth.currentUser!.uid,
                        );
                      }
                      // setState(() {
                      animateList();
                      controller.clear();
                      // });
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8, right: 8),
                      child: CircleAvatar(
                        backgroundColor: kPrimaryColor1,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
