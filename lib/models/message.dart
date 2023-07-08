import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  /// The generated code assumes these values exist in JSON.
  final String senderId, text;

  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime timestamp;

  /// Connect the generated [_$MessageFromJson] function to the `fromJson`
  /// factory.
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Message({
    required this.senderId,
    required this.text,
    required this.timestamp,
  });
  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) {
    return timestamp.toDate();
  }

  static Timestamp _dateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }

  /// Connect the generated [_$MessageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
