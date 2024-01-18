import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

// g.dart 파일 생성 : dart run build_runner build

@JsonSerializable()
class User {
  DateTime createdAt;
  DateTime updatedAt;
  String accountName;
  String name;

  String profileImage;
  bool faceSignRegistered;

  User({
    required this.createdAt,
    required this.updatedAt,
    required this.accountName,
    required this.name,
    required this.faceSignRegistered,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
