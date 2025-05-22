import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

// g.dart 파일 생성 : dart run build_runner build

@freezed
class Kiosk with _$Kiosk {
  const factory Kiosk({
    required String id,
    required String name,
  }) = _Kiosk;

  factory Kiosk.fromJson(Map<String, dynamic> json) => _$KioskFromJson(json);
}

@freezed
class Passcode with _$Passcode {
  const factory Passcode({
    required String passcode,
    required int expiresIn,
  }) = _Passcode;

  factory Passcode.fromJson(Map<String, dynamic> json) => _$PasscodeFromJson(json);
}
