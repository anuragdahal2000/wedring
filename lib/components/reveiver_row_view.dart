import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wedring/models/message.dart';

class ReceiverRowView extends StatelessWidget {
  // const ReceiverRowView({Key? key, required this.index}) : super(key: key);

  // final int index;
  final Message message;

  const ReceiverRowView({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
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
