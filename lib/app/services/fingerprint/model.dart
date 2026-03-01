import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Fingerprint with _$Fingerprint {
  const factory Fingerprint({
    required String name,
  }) = _Fingerprint;

  factory Fingerprint.fromJson(Map<String, dynamic> json) => _$FingerprintFromJson(json);
}
