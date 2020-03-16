import 'package:json_annotation/json_annotation.dart';

part 'AboutModel.g.dart';

@JsonSerializable()
class AboutModel {
  final List address;
  final String date;
  final List description;
  final String detail;
  final String timing;
  final List title;
  final List venues;
  final String imageUrl;

  AboutModel(
      {this.address,
      this.date,
      this.description,
      this.detail,
      this.timing,
      this.title,
      this.venues,this.imageUrl});

  factory AboutModel.fromJson(Map<String, dynamic> json) =>
      _$AboutModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutModelToJson(this);
}
