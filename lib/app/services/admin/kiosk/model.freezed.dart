// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Kiosk _$KioskFromJson(Map<String, dynamic> json) {
  return _Kiosk.fromJson(json);
}

/// @nodoc
mixin _$Kiosk {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this Kiosk to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Kiosk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KioskCopyWith<Kiosk> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KioskCopyWith<$Res> {
  factory $KioskCopyWith(Kiosk value, $Res Function(Kiosk) then) =
      _$KioskCopyWithImpl<$Res, Kiosk>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$KioskCopyWithImpl<$Res, $Val extends Kiosk>
    implements $KioskCopyWith<$Res> {
  _$KioskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Kiosk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KioskImplCopyWith<$Res> implements $KioskCopyWith<$Res> {
  factory _$$KioskImplCopyWith(
          _$KioskImpl value, $Res Function(_$KioskImpl) then) =
      __$$KioskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$KioskImplCopyWithImpl<$Res>
    extends _$KioskCopyWithImpl<$Res, _$KioskImpl>
    implements _$$KioskImplCopyWith<$Res> {
  __$$KioskImplCopyWithImpl(
      _$KioskImpl _value, $Res Function(_$KioskImpl) _then)
      : super(_value, _then);

  /// Create a copy of Kiosk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$KioskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KioskImpl with DiagnosticableTreeMixin implements _Kiosk {
  const _$KioskImpl({required this.id, required this.name});

  factory _$KioskImpl.fromJson(Map<String, dynamic> json) =>
      _$$KioskImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Kiosk(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Kiosk'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KioskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of Kiosk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KioskImplCopyWith<_$KioskImpl> get copyWith =>
      __$$KioskImplCopyWithImpl<_$KioskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KioskImplToJson(
      this,
    );
  }
}

abstract class _Kiosk implements Kiosk {
  const factory _Kiosk({required final String id, required final String name}) =
      _$KioskImpl;

  factory _Kiosk.fromJson(Map<String, dynamic> json) = _$KioskImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of Kiosk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KioskImplCopyWith<_$KioskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Passcode _$PasscodeFromJson(Map<String, dynamic> json) {
  return _Passcode.fromJson(json);
}

/// @nodoc
mixin _$Passcode {
  String get passcode => throw _privateConstructorUsedError;
  String get expiresIn => throw _privateConstructorUsedError;

  /// Serializes this Passcode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Passcode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PasscodeCopyWith<Passcode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasscodeCopyWith<$Res> {
  factory $PasscodeCopyWith(Passcode value, $Res Function(Passcode) then) =
      _$PasscodeCopyWithImpl<$Res, Passcode>;
  @useResult
  $Res call({String passcode, String expiresIn});
}

/// @nodoc
class _$PasscodeCopyWithImpl<$Res, $Val extends Passcode>
    implements $PasscodeCopyWith<$Res> {
  _$PasscodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Passcode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passcode = null,
    Object? expiresIn = null,
  }) {
    return _then(_value.copyWith(
      passcode: null == passcode
          ? _value.passcode
          : passcode // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PasscodeImplCopyWith<$Res>
    implements $PasscodeCopyWith<$Res> {
  factory _$$PasscodeImplCopyWith(
          _$PasscodeImpl value, $Res Function(_$PasscodeImpl) then) =
      __$$PasscodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String passcode, String expiresIn});
}

/// @nodoc
class __$$PasscodeImplCopyWithImpl<$Res>
    extends _$PasscodeCopyWithImpl<$Res, _$PasscodeImpl>
    implements _$$PasscodeImplCopyWith<$Res> {
  __$$PasscodeImplCopyWithImpl(
      _$PasscodeImpl _value, $Res Function(_$PasscodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Passcode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passcode = null,
    Object? expiresIn = null,
  }) {
    return _then(_$PasscodeImpl(
      passcode: null == passcode
          ? _value.passcode
          : passcode // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PasscodeImpl with DiagnosticableTreeMixin implements _Passcode {
  const _$PasscodeImpl({required this.passcode, required this.expiresIn});

  factory _$PasscodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PasscodeImplFromJson(json);

  @override
  final String passcode;
  @override
  final String expiresIn;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Passcode(passcode: $passcode, expiresIn: $expiresIn)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Passcode'))
      ..add(DiagnosticsProperty('passcode', passcode))
      ..add(DiagnosticsProperty('expiresIn', expiresIn));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasscodeImpl &&
            (identical(other.passcode, passcode) ||
                other.passcode == passcode) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, passcode, expiresIn);

  /// Create a copy of Passcode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasscodeImplCopyWith<_$PasscodeImpl> get copyWith =>
      __$$PasscodeImplCopyWithImpl<_$PasscodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PasscodeImplToJson(
      this,
    );
  }
}

abstract class _Passcode implements Passcode {
  const factory _Passcode(
      {required final String passcode,
      required final String expiresIn}) = _$PasscodeImpl;

  factory _Passcode.fromJson(Map<String, dynamic> json) =
      _$PasscodeImpl.fromJson;

  @override
  String get passcode;
  @override
  String get expiresIn;

  /// Create a copy of Passcode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasscodeImplCopyWith<_$PasscodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
