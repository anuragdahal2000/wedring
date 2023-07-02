import 'package:flutter/material.dart';

class SenderRowView extends StatelessWidget {
  const SenderRowView({Key? key, required this.index}) : super(key: key);

  final int index;

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
          child: const Text(
            'chatModelList.elementAt(index).message',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white),
            softWrap: true,
          ),
        ),
      ]),
      subtitle: const Padding(
        padding: EdgeInsets.only(right: 8, top: 4),
        child: Text(
          '10:03 AM',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 10),
        ),
      ),
      trailing: const CircleAvatar(
        backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
      ),
    );
  }
}
