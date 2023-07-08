import 'package:cached_network_image/cached_network_image.dart';
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
  final String? chatId;
  final user.User participant;
  final bool isNewChat;

  const SingleChat({
    super.key,
    this.chatId,
    required this.participant,
    this.isNewChat = false,
  });
  // : assert(isNewChat == true ? chatId == null : true);

  @override
  SingleChatState createState() => SingleChatState();
}

class SingleChatState extends State<SingleChat> {
  var controller = TextEditingController();
  var scrollController = ScrollController();

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
          leading: widget.isNewChat
              ? const SizedBox.shrink()
              : CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.participant.profileImage ??
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
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 20),
        //     child: Icon(Icons.videocam_rounded),
        //   ),
        //   Padding(
        //     padding: EdgeInsets.only(right: 20),
        //     child: Icon(Icons.call),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Builder(
              builder: (context) {
                if (widget.isNewChat) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.participant.profileImage ??
                              'https://picsum.photos/250?image=9',
                          fit: BoxFit.contain,
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 38,
                          ),
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          'Start typing to send a message',
                          style: kRegular14,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
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
                                        displayPictureURL:
                                            widget.participant.profileImage,
                                      )
                                    : ReceiverRowView(
                                        message: message,
                                        displayPictureURL:
                                            auth.currentUser!.photoURL,
                                      );
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
                          context,
                          widget.participant,
                        );
                      } else {
                        chatController.sendMessage(
                          controller.text,
                          widget.chatId!,
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
