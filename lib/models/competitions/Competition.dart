import 'package:json_annotation/json_annotation.dart';

part 'Competition.g.dart';

@JsonSerializable()
class Competition {
  final String description;
  final String imageUrl;
  final String rulesDescription;
  final String rulesTitle;
  final String title;
  final String heading;
  final String shortHeading;

  Competition(
      {this.description,
      this.imageUrl,
      this.rulesDescription,
      this.rulesTitle,
      this.title,this.heading,this.shortHeading});

  factory Competition.fromJson(Map<String, dynamic> json) =>
      _$CompetitionFromJson(json);

  Map<String, dynamic> toJson() => _$CompetitionToJson(this);
}
