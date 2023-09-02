import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String uid;
  final String name;
  final String email;
  final String phone;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime? dateOfBirth;
  final String? gender;
  final String? religion;
  final String? community;
  // final String country;
  final String? state;
  final String? city;
  @JsonKey(fromJson: maritalStatusFromJson, toJson: maritalStatusToJson)
  final MaritalStatus maritalStatus;
  @JsonKey(fromJson: foodPreferenceFromJson, toJson: foodPreferenceToJson)
  final FoodPreference foodPreference;
  final String? height;
  final String? weight;
  final String? education;
  final String? occupationSector;
  final String? occupation;
  final String? annualIncome;
  final String? about;
  final String? profileImage;
  final List<String>? interests;
  final List<String> friends;
  final bool? isVerifiedByAdmin;
  final String? gotra;
  final List<String> likedUsers;
  final List<String> dislikedUsers;
  final List<String> blockedUsers;
  final List<String> removeMatchedUsers;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.dateOfBirth,
    this.gender = "Male",
    this.religion = "Hindu",
    this.gotra = "Agasti (अगस्ती)",
    this.community = "Brahmin",
    //  this.country,
    this.state = "Bagmati",
    this.city = "Kathmandu",
    this.maritalStatus = MaritalStatus.single,
    this.foodPreference = FoodPreference.vegetarian,
    this.height = "180",
    this.weight = "55",
    this.education = "Bachelors",
    this.occupationSector = "Private",
    this.occupation = "Software Engineer",
    this.annualIncome = "100000",
    this.about,
    this.profileImage,
    this.interests,
    this.friends = const [],
    this.isVerifiedByAdmin = false,
    this.likedUsers = const [],
    this.dislikedUsers = const [],
    this.blockedUsers = const [],
    this.removeMatchedUsers = const [],
  });

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static DateTime? _dateTimeFromTimestamp(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  static Timestamp? _dateTimeToTimestamp(DateTime? dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime) : null;
  }

  static MaritalStatus maritalStatusFromJson(String value) {
    switch (value) {
      case 'Married':
        return MaritalStatus.married;
      case 'Never Married':
        return MaritalStatus.single;
      case 'Divorced':
        return MaritalStatus.divorced;
      case 'Widowed':
        return MaritalStatus.widowed;
      default:
        throw ArgumentError('Unknown marital status value: $value');
    }
  }

  static String maritalStatusToJson(MaritalStatus maritalStatus) {
    switch (maritalStatus) {
      case MaritalStatus.married:
        return 'Married';
      case MaritalStatus.single:
        return 'Never Married';
      case MaritalStatus.divorced:
        return 'Divorced';
      case MaritalStatus.widowed:
        return 'Widowed';
    }
  }

  static FoodPreference foodPreferenceFromJson(String value) {
    switch (value) {
      case 'Vegetarian':
        return FoodPreference.vegetarian;
      case 'Non-Vegetarian':
        return FoodPreference.nonVegetarian;
      case 'Vegan':
        return FoodPreference.vegan;
      case 'Eggetarian':
        return FoodPreference.eggetarian;
      default:
        throw ArgumentError('Unknown food preference value: $value');
    }
  }

  static String foodPreferenceToJson(FoodPreference foodPreference) {
    switch (foodPreference) {
      case FoodPreference.vegetarian:
        return 'Vegetarian';
      case FoodPreference.nonVegetarian:
        return 'Non-Vegetarian';
      case FoodPreference.vegan:
        return 'Vegan';
      case FoodPreference.eggetarian:
        return 'Eggetarian';
    }
  }
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
