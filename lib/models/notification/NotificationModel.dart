import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NotificationModel.g.dart';

@JsonSerializable()
class NotificationModel {
  String to;
  Mynotification notification;

  NotificationModel({@required this.to, @required this.notification});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class Mynotification {
  String body; //'": "Welcome tp WTQ",
  bool content_available; //": true,
  String priority; //": "high",
  String title;

  Mynotification(
      {@required this.body,
      @required this.content_available,
      @required this.priority,
      @required this.title}); //": "WTQ"

  factory Mynotification.fromJson(Map<String, dynamic> json) =>
      _$MynotificationFromJson(json);

  Map<String, dynamic> toJson() => _$MynotificationToJson(this);
}
