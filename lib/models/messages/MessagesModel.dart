import 'package:flutter_pk/models/user/UserModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MessagesModel.g.dart';

@JsonSerializable()
class MessageModel {
  @JsonKey(nullable: true)
  String id;
  @JsonKey(nullable: true)
  DateTime date;
  @JsonKey(nullable: true)
  String text;
  @JsonKey(nullable: true)
  UserModel user;
  @JsonKey(nullable: true)
  String title;
  @JsonKey(nullable: true)
  String imageUrl;

  MessageModel(
      {this.id, this.date, this.text, this.user, this.title, this.imageUrl});

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
