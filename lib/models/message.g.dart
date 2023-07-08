// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      senderId: json['senderId'] as String,
      text: json['text'] as String,
      timestamp: Message._dateTimeFromTimestamp(json['timestamp'] as Timestamp),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'senderId': instance.senderId,
      'text': instance.text,
      'timestamp': Message._dateTimeToTimestamp(instance.timestamp),
    };
