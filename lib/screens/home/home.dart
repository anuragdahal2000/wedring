import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedring/components/swipe_card.dart';
import 'package:wedring/utils/constant.dart';

import '../../utils/collection_helper.dart';

import 'package:wedring/models/user.dart' as u;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDeckEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // IconButton.outlined(
            //   color: kPrimaryColor2,
            //   onPressed: () => {
            //     showModalBottomSheet(
            //       builder: (context) => const SearchDialog(),
            //       context: context,
            //       isScrollControlled: true,
            //     )
            //   },
            //   icon: Icon(Icons.filter_b_and_w_sharp),
            //   visualDensity: VisualDensity.compact,
            // ),
          ],
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
              final deck = SwipingCardDeck(
                cardDeck: matches.map((user) => SwipeCard(user: user)).toList(),
                onDeckEmpty: () => {
                  setState(() {
                    isDeckEmpty = true;
                  })
                },
                onLeftSwipe: (Card card) => debugPrint("Swiped left!"),
                onRightSwipe: (Card card) => debugPrint("Swiped right!"),
                cardWidth: 380,
                swipeThreshold: MediaQuery.of(context).size.width / 3,
                minimumVelocity: 2000,
                rotationFactor: 0.8 / 3.14,
                swipeAnimationDuration: const Duration(milliseconds: 800),
                disableDragging: false,
              );
              if (isDeckEmpty) {
                return const Center(
                  child: Text(
                    'No more matches',
                    style: kSemiBold18,
                  ),
                );
              }
              return Column(
                children: [
                  deck,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.filled(
                        icon: const Icon(
                          Icons.clear,
                        ),
                        onPressed: deck.animationActive
                            ? null
                            : () => deck.swipeLeft(),
                      ),
                      const SizedBox(width: 20),
                      IconButton.filled(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark),
                      ),
                      const SizedBox(width: 20),
                      IconButton.filled(
                        icon: const Icon(
                          Icons.favorite,
                        ),
                        onPressed: deck.animationActive
                            ? null
                            : () => deck.swipeRight(),
                      ),
                    ],
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
      ],
    );
  }
}

class SwipeCard extends Card {
  final u.User user;

  const SwipeCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryColor1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 550,
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: user.profileImage ?? '',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/placeholder-image.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        user.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    children: user.interests
                        .map(
                          (intrest) => Chip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            visualDensity: VisualDensity.compact,
                            backgroundColor: kPrimaryColor1,
                            label: Text(
                              intrest,
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
