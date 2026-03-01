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

FingerprintPasscode _$FingerprintPasscodeFromJson(Map<String, dynamic> json) {
  return _FingerprintPasscode.fromJson(json);
}

/// @nodoc
mixin _$FingerprintPasscode {
  String get passcode => throw _privateConstructorUsedError;
  int get expiresIn => throw _privateConstructorUsedError;

  /// Serializes this FingerprintPasscode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FingerprintPasscode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FingerprintPasscodeCopyWith<FingerprintPasscode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FingerprintPasscodeCopyWith<$Res> {
  factory $FingerprintPasscodeCopyWith(
          FingerprintPasscode value, $Res Function(FingerprintPasscode) then) =
      _$FingerprintPasscodeCopyWithImpl<$Res, FingerprintPasscode>;
  @useResult
  $Res call({String passcode, int expiresIn});
}

/// @nodoc
class _$FingerprintPasscodeCopyWithImpl<$Res, $Val extends FingerprintPasscode>
    implements $FingerprintPasscodeCopyWith<$Res> {
  _$FingerprintPasscodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FingerprintPasscode
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
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FingerprintPasscodeImplCopyWith<$Res>
    implements $FingerprintPasscodeCopyWith<$Res> {
  factory _$$FingerprintPasscodeImplCopyWith(_$FingerprintPasscodeImpl value,
          $Res Function(_$FingerprintPasscodeImpl) then) =
      __$$FingerprintPasscodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String passcode, int expiresIn});
}

/// @nodoc
class __$$FingerprintPasscodeImplCopyWithImpl<$Res>
    extends _$FingerprintPasscodeCopyWithImpl<$Res, _$FingerprintPasscodeImpl>
    implements _$$FingerprintPasscodeImplCopyWith<$Res> {
  __$$FingerprintPasscodeImplCopyWithImpl(_$FingerprintPasscodeImpl _value,
      $Res Function(_$FingerprintPasscodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of FingerprintPasscode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passcode = null,
    Object? expiresIn = null,
  }) {
    return _then(_$FingerprintPasscodeImpl(
      passcode: null == passcode
          ? _value.passcode
          : passcode // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FingerprintPasscodeImpl
    with DiagnosticableTreeMixin
    implements _FingerprintPasscode {
  const _$FingerprintPasscodeImpl(
      {required this.passcode, required this.expiresIn});

  factory _$FingerprintPasscodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$FingerprintPasscodeImplFromJson(json);

  @override
  final String passcode;
  @override
  final int expiresIn;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FingerprintPasscode(passcode: $passcode, expiresIn: $expiresIn)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FingerprintPasscode'))
      ..add(DiagnosticsProperty('passcode', passcode))
      ..add(DiagnosticsProperty('expiresIn', expiresIn));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FingerprintPasscodeImpl &&
            (identical(other.passcode, passcode) ||
                other.passcode == passcode) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, passcode, expiresIn);

  /// Create a copy of FingerprintPasscode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FingerprintPasscodeImplCopyWith<_$FingerprintPasscodeImpl> get copyWith =>
      __$$FingerprintPasscodeImplCopyWithImpl<_$FingerprintPasscodeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FingerprintPasscodeImplToJson(
      this,
    );
  }
}

abstract class _FingerprintPasscode implements FingerprintPasscode {
  const factory _FingerprintPasscode(
      {required final String passcode,
      required final int expiresIn}) = _$FingerprintPasscodeImpl;

  factory _FingerprintPasscode.fromJson(Map<String, dynamic> json) =
      _$FingerprintPasscodeImpl.fromJson;

  @override
  String get passcode;
  @override
  int get expiresIn;

  /// Create a copy of FingerprintPasscode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FingerprintPasscodeImplCopyWith<_$FingerprintPasscodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
