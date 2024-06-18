import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

// g.dart 파일 생성 : dart run build_runner build

@JsonSerializable()
class User {
  String email;
  String name;

  String profileImage;

  User({
    required this.email,
    required this.name,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
