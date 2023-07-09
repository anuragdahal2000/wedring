import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedring/utils/constant.dart';

import '../../utils/collection_helper.dart';
import 'package:wedring/models/user.dart' as u;
import 'package:go_router/go_router.dart';

class MyMatches extends StatelessWidget {
  const MyMatches({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Matches',
            style: kBold20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'This is a list of people you have liked you and your matches',
              style: kRegular14,
            ),
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection(CollectionHelper.userCollection)
                .where(
                  'uid',
                  isNotEqualTo: FirebaseAuth.instance.currentUser!.uid,
                )
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final matches = snapshot.data!.docs
                    .map(
                      (e) => u.User.fromJson(e.data()),
                    )
                    .toList();
                return Expanded(
                  child: GridView.builder(
                    itemCount: matches.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.80,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, idx) {
                      final user = matches[idx];
                      return GestureDetector(
                        onTap: () {
                          context.goNamed('match-user', pathParameters: {
                            'userId': user.uid,
                          });
                        },
                        child: Card(
                          child: CachedNetworkImage(
                            imageUrl: user.profileImage ??
                                'https://picsum.photos/id/237/200/300',
                            imageBuilder: (context, imageProvider) => Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 8,
                                    ),
                                    child: Wrap(
                                      children: [
                                        Text(
                                          user.name,
                                          style: kSemiBold16.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          ', ${user.weight}',
                                          style: kMedium14.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(4),
                                      bottomRight: Radius.circular(4),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 6.0,
                                        sigmaY: 6.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 24,
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () {
                                                context.goNamed(
                                                  'single-chat',
                                                  extra: user,
                                                  pathParameters: {
                                                    'chatId': user.uid,
                                                  },
                                                  queryParameters: {
                                                    'new': 'true',
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.messenger_outline,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
