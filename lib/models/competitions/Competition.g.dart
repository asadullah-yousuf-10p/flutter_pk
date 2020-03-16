// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Competition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Competition _$CompetitionFromJson(Map<String, dynamic> json) {
  return Competition(
    description: json['description'] as String,
    imageUrl: json['imageUrl'] as String,
    rulesDescription: json['rulesDescription'] as String,
    rulesTitle: json['rulesTitle'] as String,
    title: json['title'] as String,
    heading: json['heading'] as String,
    shortHeading: json['shortHeading'] as String
  );
}

Map<String, dynamic> _$CompetitionToJson(Competition instance) =>
    <String, dynamic>{
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'rulesDescription': instance.rulesDescription,
      'rulesTitle': instance.rulesTitle,
      'title': instance.title,
      'heading': instance.heading,
      'shortHeading': instance.shortHeading
    };
