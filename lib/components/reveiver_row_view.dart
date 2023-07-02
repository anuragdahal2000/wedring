import 'package:flutter/material.dart';

class ReceiverRowView extends StatelessWidget {
  const ReceiverRowView({Key? key, required this.index}) : super(key: key);

  final int index;

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
            child: const Text(
              'chatModelList.elementAt(index).message,',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      trailing: Container(
        width: 50,
      ),
      subtitle: const Padding(
        padding: EdgeInsets.only(left: 8, top: 4),
        child: Text(
          '8:04 AM',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
