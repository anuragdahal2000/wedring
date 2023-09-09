import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wedring/utils/collection_helper.dart';

import 'package:wedring/models/user.dart' as u;
import 'package:go_router/go_router.dart';

class LikedUsers extends StatefulWidget {
  const LikedUsers({super.key});

  @override
  State<LikedUsers> createState() => _LikedUsersState();
}

class _LikedUsersState extends State<LikedUsers> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection(CollectionHelper.userCollection)
            .doc(_auth.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = u.User.fromJson(snapshot.data!.data()!);
            if (user.likedUsers.isEmpty) {
              return const Center(
                child: Text('No liked users yet'),
              );
            }
            return ListView.builder(
                itemCount: user.likedUsers.length,
                itemBuilder: (context, index) {
                  final likedUserId = user.likedUsers[index];
                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection(CollectionHelper.userCollection)
                        .doc(likedUserId)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final likedUser =
                            u.User.fromJson(snapshot.data!.data()!);
                        return ListTile(
                          onTap: () {
                            context
                                .goNamed('liked-user-details', pathParameters: {
                              'userId': likedUserId,
                            });
                          },
                          leading: CircleAvatar(
                            radius: 24.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage: likedUser.profileImage != null
                                ? NetworkImage(likedUser.profileImage!)
                                : Image.asset(
                                    'assets/images/placeholder-image.png',
                                  ).image,
                          ),
                          title: Text(likedUser.name),
                          subtitle: likedUser.likedUsers
                                  .contains(_auth.currentUser!.uid)
                              ? const Text('has liked you back')
                              : null,
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: const TitlePlaceholder(
                            width: double.infinity,
                          ),
                        );
                      }
                    },
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 12.0,
            color: Colors.white,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: width,
            height: 12.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({
    Key? key,
    required this.lineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96.0,
            height: 72.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                Container(
                  width: 100.0,
                  height: 10.0,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
