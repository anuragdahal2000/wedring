import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wedring/models/message.dart';

class SenderRowView extends StatelessWidget {
  // const SenderRowView({Key? key, required this.index}) : super(key: key);

  // final int index;
  final Message message;

  const SenderRowView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
      ),
      visualDensity: VisualDensity.comfortable,
      title: Wrap(alignment: WrapAlignment.end, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xffD11C2D),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            message.text,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white),
            softWrap: true,
          ),
        ),
      ]),
      subtitle: Padding(
        padding: const EdgeInsets.only(right: 8, top: 4),
        child: Text(
          DateFormat.jm().format(message.timestamp),
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 10),
        ),
      ),
      trailing: const CircleAvatar(
        backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
      ),
    );
  }
}
