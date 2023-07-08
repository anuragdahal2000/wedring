// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      id: json['id'] as String,
      participantsId: (json['participantsId'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastMessage: json['lastMessage'] as String?,
      lastSentAt: Chat._dateTimeFromTimestamp(json['lastSentAt'] as Timestamp?),
      isSeen: json['isSeen'] as bool? ?? false,
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'participantsId': instance.participantsId,
      'lastMessage': instance.lastMessage,
      'isSeen': instance.isSeen,
      'messages': instance.messages,
      'id': instance.id,
      'lastSentAt': Chat._dateTimeToTimestamp(instance.lastSentAt),
    };
