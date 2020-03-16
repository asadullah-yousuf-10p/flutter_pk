// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    photoUrl: json['photoUrl'] as String,
    mobileNumber: json['mobileNumber'] as String,
    isRegistered: json['isRegistered'] as bool,
    isContributor: json['isContributor'] as bool,
    isPresent: json['isPresent'] as bool,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'mobileNumber': instance.mobileNumber,
      'isRegistered': instance.isRegistered,
      'isContributor': instance.isContributor,
      'isPresent': instance.isPresent,
    };
