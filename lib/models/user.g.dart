// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      dateOfBirth:
          User._dateTimeFromTimestamp(json['dateOfBirth'] as Timestamp?),
      gender: json['gender'] as String? ?? "Male",
      religion: json['religion'] as String? ?? "Hindu",
      gotra: json['gotra'] as String? ?? "Agasti (अगस्ती)",
      community: json['community'] as String? ?? "Brahmin",
      state: json['state'] as String? ?? "Bagmati",
      city: json['city'] as String? ?? "Kathmandu",
      maritalStatus: json['maritalStatus'] == null
          ? MaritalStatus.single
          : User.maritalStatusFromJson(json['maritalStatus'] as String),
      foodPreference: json['foodPreference'] == null
          ? FoodPreference.vegetarian
          : User.foodPreferenceFromJson(json['foodPreference'] as String),
      height: json['height'] as String? ?? "180",
      weight: json['weight'] as String? ?? "55",
      education: json['education'] as String? ?? "Bachelors",
      occupationSector: json['occupationSector'] as String? ?? "Private",
      occupation: json['occupation'] as String? ?? "Software Engineer",
      annualIncome: json['annualIncome'] as String? ?? "100000",
      about: json['about'] as String?,
      profileImage: json['profileImage'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isVerifiedByAdmin: json['isVerifiedByAdmin'] as bool? ?? false,
      likedUsers: (json['likedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dislikedUsers: (json['dislikedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      blockedUsers: (json['blockedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      removeMatchedUsers: (json['removeMatchedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'dateOfBirth': User._dateTimeToTimestamp(instance.dateOfBirth),
      'gender': instance.gender,
      'religion': instance.religion,
      'community': instance.community,
      'state': instance.state,
      'city': instance.city,
      'maritalStatus': User.maritalStatusToJson(instance.maritalStatus),
      'foodPreference': User.foodPreferenceToJson(instance.foodPreference),
      'height': instance.height,
      'weight': instance.weight,
      'education': instance.education,
      'occupationSector': instance.occupationSector,
      'occupation': instance.occupation,
      'annualIncome': instance.annualIncome,
      'about': instance.about,
      'profileImage': instance.profileImage,
      'interests': instance.interests,
      'friends': instance.friends,
      'isVerifiedByAdmin': instance.isVerifiedByAdmin,
      'gotra': instance.gotra,
      'likedUsers': instance.likedUsers,
      'dislikedUsers': instance.dislikedUsers,
      'blockedUsers': instance.blockedUsers,
      'removeMatchedUsers': instance.removeMatchedUsers,
    };
