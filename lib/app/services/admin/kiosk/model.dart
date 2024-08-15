import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

// g.dart 파일 생성 : dart run build_runner build

@JsonSerializable()
class Kiosk {
  String id;
  String name;

  Kiosk({
    required this.id,
    required this.name,
  });

  factory Kiosk.fromJson(Map<String, dynamic> json) => _$KioskFromJson(json);

  Map<String, dynamic> toJson() => _$KioskToJson(this);
}

@JsonSerializable()
class Passcode {
  String passcode;
  int expiresIn;

  Passcode({
    required this.passcode,
    required this.expiresIn,
  });

  factory Passcode.fromJson(Map<String, dynamic> json) =>
      _$PasscodeFromJson(json);

  Map<String, dynamic> toJson() => _$PasscodeToJson(this);
}
