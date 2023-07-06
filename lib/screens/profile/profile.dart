import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedring/utils/constant.dart';

import '../Info/intrests.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<IntrestModel> _intrest = [
    IntrestModel(name: 'Photography', icon: Icons.camera_alt_outlined),
    IntrestModel(name: 'Music', icon: Icons.music_note_outlined),
    IntrestModel(name: 'Dance', icon: Icons.dynamic_feed),
    IntrestModel(name: 'Travel', icon: Icons.airplanemode_active),
    IntrestModel(name: 'Food', icon: Icons.fastfood_outlined),
    IntrestModel(name: 'Sports', icon: Icons.sports_basketball_outlined),
  ];

  late User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: currentUser.photoURL!,
          imageBuilder: (context, imageProvider) => Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  currentUser.displayName ?? 'John Doe',
                  style: kBold18,
                ),
                const SizedBox(
                  width: 10,
                ),
                currentUser.emailVerified
                    ? const Icon(
                        Icons.verified,
                        color: Colors.green,
                      )
                    : const SizedBox()
              ],
            ),
            Text(
              currentUser.email!,
              style: kMedium12,
            ),
            const Row(
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
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
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
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'About Me',
          style: kBold16,
        ),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl. Nulla euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl.',
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(),
        const Text(
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
