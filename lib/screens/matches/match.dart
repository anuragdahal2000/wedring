import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedring/utils/constant.dart';

import '../../algo.dart';
import '../../controllers/match_controller.dart';
import '../../utils/collection_helper.dart';
import 'package:wedring/models/user.dart' as u;
import 'package:go_router/go_router.dart';

class MyMatches extends StatefulWidget {
  const MyMatches({super.key});

  @override
  State<MyMatches> createState() => _MyMatchesState();
}

class _MyMatchesState extends State<MyMatches> {
  final _auth = FirebaseAuth.instance;
  final MatchController _matchController = MatchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: FirebaseFirestore.instance
          .collection(CollectionHelper.userCollection)
          .doc(_auth.currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final currentUser = u.User.fromJson(snapshot.data!.data()!);
          return Column(
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
                    final usersList = snapshot.data!.docs
                        .map(
                          (e) => u.User.fromJson(e.data()),
                        )
                        .where((element) => !currentUser.removeMatchedUsers
                            .contains(element.uid))
                        .toList();
                    final matches = findMatches(
                      currentUser,
                      usersList,
                      similarityThreshold: 10,
                    );
                    if (matches.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text('No Matches Found'),
                        ),
                      );
                    }
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
                                imageUrl: user.profileImage ?? '',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                                                color: kPrimaryColor1,
                                              ),
                                            ),
                                            Text(
                                              ', ${user.weight}',
                                              style: kMedium14.copyWith(
                                                color: kPrimaryColor1,
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
                                                  onPressed: () {
                                                    _matchController
                                                        .removeMatchedUser(
                                                      _auth.currentUser!.uid,
                                                      user.uid,
                                                    );
                                                  },
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
                                errorWidget: (context, url, error) => Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/placeholder-image.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                          vertical: 4,
                                        ),
                                        child: Wrap(
                                          children: [
                                            Text(
                                              user.name,
                                              style: kSemiBold16.copyWith(
                                                color: kPrimaryColor1,
                                              ),
                                            ),
                                            Text(
                                              ', ${user.weight}',
                                              style: kMedium14.copyWith(
                                                color: kPrimaryColor1,
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
                                                    color: kPrimaryColor1,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 24,
                                                color: kPrimaryColor1,
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
                                                    color: kPrimaryColor1,
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
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
