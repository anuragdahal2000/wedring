import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String uuid;
  final String name;
  final String email;
  final String phone;
  final DateTime? dateOfBirth;
  final String gender;
  final String religion;
  final String community;
  // final String country;
  final String state;
  final String city;
  final MaritalStatus maritalStatus;
  final FoodPreference foodPreference;
  final String height;
  final String weight;
  final String education;
  final String occupationSector;
  final String occupation;
  final String annualIncome;
  final String about;
  final String? profileImage;
  final List<String> interests;
  final List<String> friends;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User({
    required this.uuid,
    required this.name,
    required this.email,
    required this.phone,
    this.dateOfBirth,
    required this.gender,
    required this.religion,
    required this.community,
    // required this.country,
    required this.state,
    required this.city,
    required this.maritalStatus,
    required this.foodPreference,
    required this.height,
    required this.weight,
    required this.education,
    required this.occupationSector,
    required this.occupation,
    required this.annualIncome,
    required this.about,
    this.profileImage,
    required this.interests,
    this.friends = const [],
  });

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum MaritalStatus {
  @JsonValue('Married')
  married,
  @JsonValue('Never Married')
  single,
  @JsonValue('Divorced')
  divorced,
  @JsonValue('Widowed')
  widowed,
}

enum FoodPreference {
  @JsonValue('Vegetarian')
  vegetarian,
  @JsonValue('Non-Vegetarian')
  nonVegetarian,
  @JsonValue('Vegan')
  vegan,
  @JsonValue('Eggetarian')
  eggetarian,
}
