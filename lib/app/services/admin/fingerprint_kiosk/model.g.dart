// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FingerprintPasscodeImpl _$$FingerprintPasscodeImplFromJson(
        Map<String, dynamic> json) =>
    _$FingerprintPasscodeImpl(
      passcode: json['passcode'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
    );

Map<String, dynamic> _$$FingerprintPasscodeImplToJson(
        _$FingerprintPasscodeImpl instance) =>
    <String, dynamic>{
      'passcode': instance.passcode,
      'expiresIn': instance.expiresIn,
    };
