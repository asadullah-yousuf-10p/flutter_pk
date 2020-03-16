// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AboutModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutModel _$AboutModelFromJson(Map<String, dynamic> json) {
  return AboutModel(
    address: json['address'] as List,
    date: json['date'] as String,
    description: json['description'] as List,
    detail: json['detail'] as String,
    timing: json['timing'] as String,
    title: json['title'] as List,
    venues: json['venues'] as List,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$AboutModelToJson(AboutModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'date': instance.date,
      'description': instance.description,
      'detail': instance.detail,
      'timing': instance.timing,
      'title': instance.title,
      'venues': instance.venues,
      'imageUrl': instance.imageUrl,
    };
