// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    to: json['to'] as String,
    notification: json['notification'] == null
        ? null
        : Mynotification.fromJson(json['notification'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'to': instance.to,
      'notification': instance.notification,
    };

Mynotification _$MynotificationFromJson(Map<String, dynamic> json) {
  return Mynotification(
    body: json['body'] as String,
    content_available: json['content_available'] as bool,
    priority: json['priority'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$MynotificationToJson(Mynotification instance) =>
    <String, dynamic>{
      'body': instance.body,
      'content_available': instance.content_available,
      'priority': instance.priority,
      'title': instance.title,
    };
