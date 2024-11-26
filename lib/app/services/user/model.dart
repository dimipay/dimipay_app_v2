import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'model.freezed.dart';
part 'model.g.dart';

// g.dart 파일 생성 : dart run build_runner build

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    required String profileImage,
    required String role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
