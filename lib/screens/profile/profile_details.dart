import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/controllers/auth.dart';
import 'package:wedring/utils/constant.dart';
import 'package:wedring/utils/helper.dart';

import '../../utils/collection_helper.dart';

import 'package:wedring/models/user.dart' as u;

class ProfileDetails extends StatefulWidget {
  final String userId;

  const ProfileDetails({super.key, required this.userId});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final AuthController _authController = AuthController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection(CollectionHelper.userCollection)
              .doc(widget.userId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = u.User.fromJson(snapshot.data!.data()!);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user.profileImage != null
                      ? CachedNetworkImage(
                          imageUrl: user.profileImage!,
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
                            user.name,
                            style: kBold18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          //TODO: Uncomment this when email verification is done

                          // user.emailVerified
                          //     ? const Icon(
                          //         Icons.verified,
                          //         color: Colors.green,
                          //       )
                          //     : const SizedBox()
                        ],
                      ),
                      Text(
                        user.email,
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
                          user.occupation!,
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
                    children: user.interests!
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
                  _auth.currentUser!.uid != widget.userId
                      ? FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection(CollectionHelper.userCollection)
                              .doc(_auth.currentUser!.uid)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final user =
                                  u.User.fromJson(snapshot.data!.data()!);
                              if (user.blockedUsers.contains(widget.userId)) {
                                return PrimaryButton(
                                  title: 'Unblock User',
                                  onPressed: () {
                                    _authController.unblockUser(widget.userId);
                                    showSnackBar('User unblocked successfully');
                                    Navigator.pop(context);
                                  },
                                );
                              } else {
                                return PrimaryButton(
                                  title: 'Block User',
                                  onPressed: () {
                                    _authController.blockUser(widget.userId);
                                    showSnackBar('User blocked successfully');
                                    Navigator.pop(context);
                                  },
                                );
                              }
                            } else {
                              return const SizedBox();
                            }
                          })
                      : const SizedBox()
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
