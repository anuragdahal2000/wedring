import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  User user;
  Tokens tokens;

  UserResponse({
    required this.user,
    required this.tokens,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        user: User.fromJson(json["user"]),
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "tokens": tokens.toJson(),
      };
}

class Tokens {
  Access access;
  Access refresh;

  Tokens({
    required this.access,
    required this.refresh,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: Access.fromJson(json["access"]),
        refresh: Access.fromJson(json["refresh"]),
      );

  Map<String, dynamic> toJson() => {
        "access": access.toJson(),
        "refresh": refresh.toJson(),
      };
}

class Access {
  String token;
  DateTime expires;

  Access({
    required this.token,
    required this.expires,
  });

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        token: json["token"],
        expires: DateTime.parse(json["expires"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expires": expires.toIso8601String(),
      };
}

class User {
  String role;
  bool isEmailVerified;
  String email;
  String name;
  String id;

  User({
    required this.role,
    required this.isEmailVerified,
    required this.email,
    required this.name,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        role: json["role"],
        isEmailVerified: json["isEmailVerified"],
        email: json["email"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "isEmailVerified": isEmailVerified,
        "email": email,
        "name": name,
        "id": id,
      };
}
