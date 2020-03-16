import 'package:json_annotation/json_annotation.dart';

part 'Speakers.g.dart';

@JsonSerializable()
class Speakers {
  @JsonKey(nullable: true)
  final String description;
  @JsonKey(nullable: true)
  final String name;
  @JsonKey(nullable: true)
  final String photoUrl;

  Speakers({this.description, this.name, this.photoUrl});

  factory Speakers.fromJson(Map<String, dynamic> json) =>
      _$SpeakersFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakersToJson(this);
}
