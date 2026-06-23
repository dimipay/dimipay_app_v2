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

Fingerprint _$FingerprintFromJson(Map<String, dynamic> json) {
  return _Fingerprint.fromJson(json);
}

/// @nodoc
mixin _$Fingerprint {
  String get name => throw _privateConstructorUsedError;

  /// Serializes this Fingerprint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Fingerprint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FingerprintCopyWith<Fingerprint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FingerprintCopyWith<$Res> {
  factory $FingerprintCopyWith(
          Fingerprint value, $Res Function(Fingerprint) then) =
      _$FingerprintCopyWithImpl<$Res, Fingerprint>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$FingerprintCopyWithImpl<$Res, $Val extends Fingerprint>
    implements $FingerprintCopyWith<$Res> {
  _$FingerprintCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fingerprint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FingerprintImplCopyWith<$Res>
    implements $FingerprintCopyWith<$Res> {
  factory _$$FingerprintImplCopyWith(
          _$FingerprintImpl value, $Res Function(_$FingerprintImpl) then) =
      __$$FingerprintImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$FingerprintImplCopyWithImpl<$Res>
    extends _$FingerprintCopyWithImpl<$Res, _$FingerprintImpl>
    implements _$$FingerprintImplCopyWith<$Res> {
  __$$FingerprintImplCopyWithImpl(
      _$FingerprintImpl _value, $Res Function(_$FingerprintImpl) _then)
      : super(_value, _then);

  /// Create a copy of Fingerprint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$FingerprintImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FingerprintImpl with DiagnosticableTreeMixin implements _Fingerprint {
  const _$FingerprintImpl({required this.name});

  factory _$FingerprintImpl.fromJson(Map<String, dynamic> json) =>
      _$$FingerprintImplFromJson(json);

  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Fingerprint(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Fingerprint'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FingerprintImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of Fingerprint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FingerprintImplCopyWith<_$FingerprintImpl> get copyWith =>
      __$$FingerprintImplCopyWithImpl<_$FingerprintImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FingerprintImplToJson(
      this,
    );
  }
}

abstract class _Fingerprint implements Fingerprint {
  const factory _Fingerprint({required final String name}) = _$FingerprintImpl;

  factory _Fingerprint.fromJson(Map<String, dynamic> json) =
      _$FingerprintImpl.fromJson;

  @override
  String get name;

  /// Create a copy of Fingerprint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FingerprintImplCopyWith<_$FingerprintImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
