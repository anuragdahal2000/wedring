import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MatchController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void swipeRight(String userId, String likedUserId) {
    debugPrint('Swiped by $userId on $likedUserId');
    _firestore.collection('users').doc(userId).update({
      "likedUsers": FieldValue.arrayUnion([likedUserId]),
    });
  }

  void swipeLeft(String userId, String dislikedUserId) {
    _firestore.collection('users').doc(userId).update({
      "dislikedUsers": FieldValue.arrayUnion([dislikedUserId]),
    });
  }
}
