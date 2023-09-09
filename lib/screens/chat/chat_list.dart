import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wedring/components/custom_textfield.dart';
import 'package:wedring/models/user.dart' as u;
import 'package:wedring/utils/constant.dart';

import '../../models/chat.dart';
import '../../utils/collection_helper.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final TextEditingController controller = TextEditingController();
  final currenUserId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomTextField(
          hintText: 'Search',
          controller: controller,
          prefixIcon: const Icon(Icons.search),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("chat")
              .where("participantsId", arrayContains: currenUserId)
              .snapshots()
              .map(
                (snapshot) =>
                    snapshot.docs.map((e) => Chat.fromJson(e.data())).toList()
                      ..sort((a, b) => b.lastSentAt!.compareTo(a.lastSentAt!)),
              ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final chats = snapshot.data ?? [];
              return Expanded(
                child: ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final participantId = chat.participantsId
                        .where(
                          (element) => element != currenUserId,
                        )
                        .first;
                    if (chats.isEmpty) {
                      return const Center(
                        child: Text('No chats yet'),
                      );
                    }
                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection(CollectionHelper.userCollection)
                          .doc(participantId)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final chatUser =
                              u.User.fromJson(snapshot.data!.data()!);
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                chatUser.profileImage ??
                                    'https://picsum.photos/250?image=9',
                              ),
                            ),
                            title: Text(
                              chatUser.name,
                              style: kSemiBold14,
                            ),
                            subtitle: Text(chat.lastMessage ?? ''),
                            trailing: chat.lastSentAt != null
                                ? Text(DateFormat.jm().format(chat.lastSentAt!))
                                : const SizedBox.shrink(),
                            onTap: () {
                              context.goNamed(
                                'single-chat',
                                pathParameters: {'chatId': chat.id},
                                extra: chatUser,
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );
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
        )
      ],
    );
  }
}
