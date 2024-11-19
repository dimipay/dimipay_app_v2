// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KioskImpl _$$KioskImplFromJson(Map<String, dynamic> json) => _$KioskImpl(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$KioskImplToJson(_$KioskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$PasscodeImpl _$$PasscodeImplFromJson(Map<String, dynamic> json) =>
    _$PasscodeImpl(
      passcode: json['passcode'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
    );

Map<String, dynamic> _$$PasscodeImplToJson(_$PasscodeImpl instance) =>
    <String, dynamic>{
      'passcode': instance.passcode,
      'expiresIn': instance.expiresIn,
    };
