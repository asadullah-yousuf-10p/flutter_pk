// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScheduleModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) {
  return ScheduleModel(
    title: json['title'] as String,
    startDateTime: ScheduleModel._fromJson(json['startDateTime'] as Timestamp),
    endDateTime: ScheduleModel._fromJson(json['endDateTime'] as Timestamp),
    description: json['description'] as String,
    city: json['city'] as String,
    shouldOpenDetail: json['shouldOpenDetail'] as bool,
    speakerId: json['speakerId'] as String,
  );
}

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'startDateTime': instance.startDateTime?.toIso8601String(),
      'endDateTime': instance.endDateTime?.toIso8601String(),
      'city': instance.city,
      'shouldOpenDetail': instance.shouldOpenDetail,
      'description': instance.description,
      'speakerId': instance.speakerId,
    };
