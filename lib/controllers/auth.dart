import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wedring/models/user.dart';
import 'package:wedring/utils/helper.dart';

import '../utils/collection_helper.dart';
import 'package:wedring/models/user.dart' as user;

class AuthController extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> createUser(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar('The account already exists for that email.');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<FirebaseAuthException?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar('Wrong password provided for that user.');
      }
      return e;
    }
    return null;
  }

  Future<FirebaseAuthException?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar('No user found for that email.');
      } else {
        showSnackBar(e.message!);
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setRegistrationPage1Details(
      String name, String email, String phone, DateTime dob, String userId) {
    _firestore.collection(CollectionHelper.userCollection).doc(userId).set({
      'uid': userId,
      'name': name,
      'email': email,
      'dateOfBirth': dob,
      'phone': phone,
      'isVerifiedByAdmin': false,
    });
  }

  void setRegistrationPage2Details(
    String gender,
    String religion,
    String community,
    String state,
    String city,
    String userId,
  ) {
    _firestore.collection(CollectionHelper.userCollection).doc(userId).update({
      'gender': gender,
      'religion': religion,
      'community': community,
      'state': state,
      'city': city,
    });
  }

  void setRegistrationPage3Details(
    MaritalStatus maritalStatus,
    FoodPreference foodPreference,
    String height,
    String weight,
    String userId,
  ) {
    _firestore.collection(CollectionHelper.userCollection).doc(userId).update({
      'maritalStatus': user.User.maritalStatusToJson(maritalStatus),
      'foodPreference': user.User.foodPreferenceToJson(foodPreference),
      'height': height,
      'weight': weight,
    });
    notifyListeners();
  }

  void setRegistrationPage4Details(String education, String occupationSector,
      String occupation, String annualIncome, String userId) {
    _firestore.collection(CollectionHelper.userCollection).doc(userId).update({
      'education': education,
      'occupationSector': occupationSector,
      'occupation': occupation,
      'annualIncome': annualIncome,
    });
  }

  void setIntersets(List<String> interests, String userId) {
    _firestore.collection(CollectionHelper.userCollection).doc(userId).update({
      'interests': interests,
    });
  }

  void uploadProfileImage(String path) async {
    final profileImgRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${_auth.currentUser!.uid}.jpg');

    try {
      await profileImgRef.putFile(File(path));
      final profileUrl = await profileImgRef.getDownloadURL();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirebaseAuth.instance.currentUser!.updatePhotoURL(profileUrl);
        _firestore
            .collection(CollectionHelper.userCollection)
            .doc(user.uid)
            .update({
          'profileImage': profileUrl,
        });
      }
    } on FirebaseException catch (e) {
      showSnackBar(e.message!, type: SnackType.error);
      throw Exception(e);
    }
  }
}
