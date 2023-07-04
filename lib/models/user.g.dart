// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String,
      religion: json['religion'] as String,
      community: json['community'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      maritalStatus: $enumDecode(_$MaritalStatusEnumMap, json['maritalStatus']),
      foodPreference:
          $enumDecode(_$FoodPreferenceEnumMap, json['foodPreference']),
      height: json['height'] as String,
      weight: json['weight'] as String,
      education: json['education'] as String,
      occupationSector: json['occupationSector'] as String,
      occupation: json['occupation'] as String,
      annualIncome: json['annualIncome'] as String,
      about: json['about'] as String,
      profileImage: json['profileImage'] as String?,
      interests:
          (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'gender': instance.gender,
      'religion': instance.religion,
      'community': instance.community,
      'state': instance.state,
      'city': instance.city,
      'maritalStatus': _$MaritalStatusEnumMap[instance.maritalStatus]!,
      'foodPreference': _$FoodPreferenceEnumMap[instance.foodPreference]!,
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
    };

const _$MaritalStatusEnumMap = {
  MaritalStatus.married: 'Married',
  MaritalStatus.single: 'Never Married',
  MaritalStatus.divorced: 'Divorced',
  MaritalStatus.widowed: 'Widowed',
};

const _$FoodPreferenceEnumMap = {
  FoodPreference.vegetarian: 'Vegetarian',
  FoodPreference.nonVegetarian: 'Non-Vegetarian',
  FoodPreference.vegan: 'Vegan',
  FoodPreference.eggetarian: 'Eggetarian',
};
