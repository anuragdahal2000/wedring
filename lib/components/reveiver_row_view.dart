import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wedring/models/message.dart';

class ReceiverRowView extends StatelessWidget {
  final Message message;

  final String? displayPictureURL;

  const ReceiverRowView({
    super.key,
    required this.message,
    this.displayPictureURL,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              displayPictureURL ?? 'https://picsum.photos/250?image=9'),
        ),
      ),
      title: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(
              message.text,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      trailing: Container(
        width: 50,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 8, top: 4),
        child: Text(
          DateFormat.jm().format(message.timestamp),
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
