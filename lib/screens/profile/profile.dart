// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wedring/util/constant.dart';

import '../Info/intrests.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final List<IntrestModel> _intrest = [
    IntrestModel(name: 'Photography', icon: Icons.camera_alt_outlined),
    IntrestModel(name: 'Music', icon: Icons.music_note_outlined),
    IntrestModel(name: 'Dance', icon: Icons.dynamic_feed),
    IntrestModel(name: 'Travel', icon: Icons.airplanemode_active),
    IntrestModel(name: 'Food', icon: Icons.fastfood_outlined),
    IntrestModel(name: 'Sports', icon: Icons.sports_basketball_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/images/onboard/1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Text(
                  'John Doe',
                  style: kBold18,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.verified,
                  color: Colors.green,
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  'Katmandu, Nepal',
                  style: kSemiBold14,
                ),
              ],
            ),
          ],
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Occupation',
                style: kBold16,
              ),
              Text(
                'Software Engineer',
                style: kSemiBold14,
              ),
            ],
          ),
        ),
        Divider(),
        const SizedBox(
          height: 10,
        ),
        Text(
          'About Me',
          style: kBold16,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl. Nulla euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl.',
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(),
        Text(
          'My Interests',
          style: kBold16,
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _intrest
              .map(
                (e) => Chip(
                  avatar: Icon(
                    e.icon,
                    color: Colors.black,
                  ),
                  label: Text(e.name),
                  backgroundColor: Colors.grey[300],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
