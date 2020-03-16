import 'package:json_annotation/json_annotation.dart';

part 'Archive.g.dart';

@JsonSerializable()
class ArchiveModel {
  final String imageUrl;
  final String title;
  final String link;

  ArchiveModel({this.imageUrl, this.title, this.link});

  factory ArchiveModel.fromJson(Map<String, dynamic> json) =>
      _$ArchiveModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArchiveModelToJson(this);
}
