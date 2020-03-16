// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Archive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArchiveModel _$ArchiveModelFromJson(Map<String, dynamic> json) {
  return ArchiveModel(
    imageUrl: json['imageUrl'] as String,
    title: json['title'] as String,
    link: json['link'] as String,
  );
}

Map<String, dynamic> _$ArchiveModelToJson(ArchiveModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'link': instance.link,
    };
