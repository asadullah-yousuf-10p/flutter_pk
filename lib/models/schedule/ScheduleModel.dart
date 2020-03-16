import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ScheduleModel.g.dart';

@JsonSerializable()
class ScheduleModel {
  @JsonKey(nullable: true)
  final String title;
  @JsonKey(fromJson: _fromJson)
  final DateTime startDateTime;
  @JsonKey(fromJson: _fromJson)
  final DateTime endDateTime;
  final String city;
  @JsonKey(nullable: true)
  final bool shouldOpenDetail;
  @JsonKey(nullable: true)
  final String description;

  @JsonKey(nullable: false)
  final String speakerId;

  ScheduleModel(
      {this.title,
      this.startDateTime,
      this.endDateTime,
      this.description,
      this.city,
      this.shouldOpenDetail,
      this.speakerId});

  static DateTime _fromJson(Timestamp timestamp) => timestamp.toDate();

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}
