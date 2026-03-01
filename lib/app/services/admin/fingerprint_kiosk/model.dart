import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class FingerprintPasscode with _$FingerprintPasscode {
  const factory FingerprintPasscode({
    required String passcode,
    required int expiresIn,
  }) = _FingerprintPasscode;

  factory FingerprintPasscode.fromJson(Map<String, dynamic> json) =>
      _$FingerprintPasscodeFromJson(json);
}
