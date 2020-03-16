import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(nullable: true)
  String id;
  @JsonKey(nullable: true)
  String name;
  @JsonKey(nullable: true)
  String email;
  @JsonKey(nullable: true)
  String photoUrl;
  @JsonKey(nullable: true)
  String mobileNumber;
  @JsonKey(nullable: true)
  bool isRegistered;
  @JsonKey(nullable: true)
  bool isContributor;
  @JsonKey(nullable: true)
  bool isPresent;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.photoUrl,
      this.mobileNumber,
      this.isRegistered = false,
      this.isContributor = false,
      this.isPresent = false});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
