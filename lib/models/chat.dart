import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wedring/models/message.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  /// The generated code assumes these values exist in JSON.
  final List<String> participantsId;
  final String? lastMessage;
  final bool? isSeen;
  final List<Message> messages;
  final String id;

  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime? lastSentAt;

  /// Connect the generated [_$ChatFromJson] function to the `fromJson`
  /// factory.
  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Chat({
    required this.id,
    required this.participantsId,
    this.lastMessage,
    this.lastSentAt,
    this.isSeen = false,
    this.messages = const [],
  });

  static DateTime? _dateTimeFromTimestamp(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  static Timestamp? _dateTimeToTimestamp(DateTime? dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime) : null;
  }

  /// Connect the generated [_$ChatToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
