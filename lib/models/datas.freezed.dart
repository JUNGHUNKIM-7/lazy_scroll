// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'datas.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DataMap _$DataMapFromJson(Map<String, dynamic> json) {
  return _DataMap.fromJson(json);
}

/// @nodoc
mixin _$DataMap {
  String? get title => throw _privateConstructorUsedError;
  String? get href => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataMapCopyWith<DataMap> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataMapCopyWith<$Res> {
  factory $DataMapCopyWith(DataMap value, $Res Function(DataMap) then) =
      _$DataMapCopyWithImpl<$Res, DataMap>;
  @useResult
  $Res call({String? title, String? href, String? created});
}

/// @nodoc
class _$DataMapCopyWithImpl<$Res, $Val extends DataMap>
    implements $DataMapCopyWith<$Res> {
  _$DataMapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? href = freezed,
    Object? created = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      href: freezed == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataMapCopyWith<$Res> implements $DataMapCopyWith<$Res> {
  factory _$$_DataMapCopyWith(
          _$_DataMap value, $Res Function(_$_DataMap) then) =
      __$$_DataMapCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? href, String? created});
}

/// @nodoc
class __$$_DataMapCopyWithImpl<$Res>
    extends _$DataMapCopyWithImpl<$Res, _$_DataMap>
    implements _$$_DataMapCopyWith<$Res> {
  __$$_DataMapCopyWithImpl(_$_DataMap _value, $Res Function(_$_DataMap) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? href = freezed,
    Object? created = freezed,
  }) {
    return _then(_$_DataMap(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      href: freezed == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DataMap implements _DataMap {
  _$_DataMap({this.title, this.href, this.created});

  factory _$_DataMap.fromJson(Map<String, dynamic> json) =>
      _$$_DataMapFromJson(json);

  @override
  final String? title;
  @override
  final String? href;
  @override
  final String? created;

  @override
  String toString() {
    return 'DataMap(title: $title, href: $href, created: $created)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DataMap &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.href, href) || other.href == href) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, href, created);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataMapCopyWith<_$_DataMap> get copyWith =>
      __$$_DataMapCopyWithImpl<_$_DataMap>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataMapToJson(
      this,
    );
  }
}

abstract class _DataMap implements DataMap {
  factory _DataMap(
      {final String? title,
      final String? href,
      final String? created}) = _$_DataMap;

  factory _DataMap.fromJson(Map<String, dynamic> json) = _$_DataMap.fromJson;

  @override
  String? get title;
  @override
  String? get href;
  @override
  String? get created;
  @override
  @JsonKey(ignore: true)
  _$$_DataMapCopyWith<_$_DataMap> get copyWith =>
      throw _privateConstructorUsedError;
}
