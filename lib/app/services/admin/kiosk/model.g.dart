// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kiosk _$KioskFromJson(Map<String, dynamic> json) => Kiosk(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$KioskToJson(Kiosk instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Passcode _$PasscodeFromJson(Map<String, dynamic> json) => Passcode(
      passcode: json['passcode'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
    );

Map<String, dynamic> _$PasscodeToJson(Passcode instance) => <String, dynamic>{
      'passcode': instance.passcode,
      'expiresIn': instance.expiresIn,
    };
