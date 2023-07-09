import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedring/utils/constant.dart';

import '../../utils/collection_helper.dart';

import 'package:wedring/models/user.dart' as u;

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  late User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection(CollectionHelper.userCollection)
              .doc(currentUser.uid)
              .get(),
          builder: (context, snapshot) {
            final user = u.User.fromJson(snapshot.data!.data()!);
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  currentUser.photoURL != null
                      ? CachedNetworkImage(
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
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : Image.asset('assets/images/logo.png'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            currentUser.displayName ?? '',
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
                      Row(
                        children: [
                          Text(
                            '${user.city}, Nepal',
                            style: kSemiBold14,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Occupation',
                          style: kBold16,
                        ),
                        Text(
                          user.occupation,
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
                    spacing: 8,
                    children: user.interests
                        .map(
                          (intrest) => Chip(
                            // horizontalTitleGap: 0,
                            // // leading: Icon(intrest.icon),
                            // title: Text(intrest),
                            label: Text(intrest),
                          ),
                        )
                        .toList(),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
