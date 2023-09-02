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
      gender: json['gender'] as String,
      religion: json['religion'] as String,
      gotra: json['gotra'] as String,
      community: json['community'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      maritalStatus:
          User.maritalStatusFromJson(json['maritalStatus'] as String),
      foodPreference:
          User.foodPreferenceFromJson(json['foodPreference'] as String),
      height: json['height'] as String,
      weight: json['weight'] as String,
      education: json['education'] as String,
      occupationSector: json['occupationSector'] as String,
      occupation: json['occupation'] as String,
      annualIncome: json['annualIncome'] as String,
      about: json['about'] as String?,
      profileImage: json['profileImage'] as String?,
      interests:
          (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isVerifiedByAdmin: json['isVerifiedByAdmin'] as bool? ?? false,
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
    };
