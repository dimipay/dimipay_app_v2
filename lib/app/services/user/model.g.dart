// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      accountName: json['accountName'] as String,
      name: json['name'] as String,
      faceSignRegistered: json['faceSignRegistered'] as bool,
      profileImage: json['profileImage'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'accountName': instance.accountName,
      'name': instance.name,
      'profileImage': instance.profileImage,
      'faceSignRegistered': instance.faceSignRegistered,
    };
