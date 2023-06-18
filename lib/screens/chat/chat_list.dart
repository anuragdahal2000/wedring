import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/custom_textfield.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Show list of users to send message to
        CustomTextField(
          hintText: 'Search',
          controller: controller,
          prefixIcon: const Icon(Icons.search),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/250?image=9',
                  ),
                ),
                title: const Text('John Doe'),
                subtitle: const Text('Hello'),
                trailing: const Text('8:04 AM'),
                onTap: () {
                  context.goNamed('single-chat');
                },
              );
            },
          ),
        )
      ],
    );
  }
}
