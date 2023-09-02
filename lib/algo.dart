import 'package:flutter/cupertino.dart';
import 'package:wedring/models/user.dart';

// Step 1: Calculate User Similarity
double calculateSimilarity(User user1, User user2) {
  double similarity = 0;

  // Compare attributes like interests
  final commonInterests = user1.interests!
      .where((interest) => user2.interests!.contains(interest))
      .toList();
  similarity += commonInterests.length.toDouble();

  // Compare attributes like height
  final heightDifference =
      (int.parse(user1.height!) - int.parse(user2.height!)).abs();
  similarity += 10 - (heightDifference / 10);

  // Compare attributes like education
  if (user1.education == user2.education) {
    similarity += 1;
  }

  // Compare attributes like occupation
  if (user1.occupation == user2.occupation) {
    similarity += 1;
  }

  if (user1.state == user2.state) {
    similarity += 1;
  }

  // Compare attributes like location
  if (user1.city == user2.city) {
    similarity += 1;
  }

  return similarity;
}

// Step 2: Find Potential Partners
List<User> findPotentialPartners(
    User targetUser, List<User> userData, double similarityThreshold) {
  final potentialPartners = <User>[];

  for (final user in userData) {
    if (user.uid != targetUser.uid &&
        user.gender != targetUser.gender &&
        user.gotra != targetUser.gotra) {
      final similarity = calculateSimilarity(targetUser, user);
      if (similarity >= similarityThreshold) {
        potentialPartners.add(user);
      }
    }
  }

  return potentialPartners;
}

List<User> findMatches(User targetUser, List<User> userData,
    {double similarityThreshold = 10}) {
  debugPrint(userData.length.toString());
  final potentialPartners =
      findPotentialPartners(targetUser, userData, similarityThreshold);

  debugPrint(potentialPartners.length.toString());

  return potentialPartners;
}
