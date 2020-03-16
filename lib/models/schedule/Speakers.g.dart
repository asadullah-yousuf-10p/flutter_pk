// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Speakers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speakers _$SpeakersFromJson(Map<String, dynamic> json) {
  return Speakers(
    description: json['description'] as String,
    name: json['name'] as String,
    photoUrl: json['photoUrl'] as String,
  );
}

Map<String, dynamic> _$SpeakersToJson(Speakers instance) => <String, dynamic>{
      'description': instance.description,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
    };
