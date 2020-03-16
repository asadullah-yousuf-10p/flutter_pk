// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessagesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return MessageModel(
    id: json['id'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    text: json['text'] as String,
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    title: json['title'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'text': instance.text,
      'user': instance.user,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };
