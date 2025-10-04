// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spotstock_api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SpotstockApiResponse<T> _$SpotstockApiResponseFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _SpotstockApiResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$SpotstockApiResponse<T> {
  T get data => throw _privateConstructorUsedError;
  ApiLinks? get links => throw _privateConstructorUsedError;
  ApiMeta? get meta => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  bool? get success => throw _privateConstructorUsedError;
  dynamic get rawResponse => throw _privateConstructorUsedError;

  /// Serializes this SpotstockApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of SpotstockApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotstockApiResponseCopyWith<T, SpotstockApiResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotstockApiResponseCopyWith<T, $Res> {
  factory $SpotstockApiResponseCopyWith(SpotstockApiResponse<T> value,
          $Res Function(SpotstockApiResponse<T>) then) =
      _$SpotstockApiResponseCopyWithImpl<T, $Res, SpotstockApiResponse<T>>;
  @useResult
  $Res call(
      {T data,
      ApiLinks? links,
      ApiMeta? meta,
      String? message,
      bool? success,
      dynamic rawResponse});

  $ApiLinksCopyWith<$Res>? get links;
  $ApiMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$SpotstockApiResponseCopyWithImpl<T, $Res,
        $Val extends SpotstockApiResponse<T>>
    implements $SpotstockApiResponseCopyWith<T, $Res> {
  _$SpotstockApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpotstockApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? links = freezed,
    Object? meta = freezed,
    Object? message = freezed,
    Object? success = freezed,
    Object? rawResponse = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as ApiLinks?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as ApiMeta?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      rawResponse: freezed == rawResponse
          ? _value.rawResponse
          : rawResponse // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }

  /// Create a copy of SpotstockApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiLinksCopyWith<$Res>? get links {
    if (_value.links == null) {
      return null;
    }

    return $ApiLinksCopyWith<$Res>(_value.links!, (value) {
      return _then(_value.copyWith(links: value) as $Val);
    });
  }

  /// Create a copy of SpotstockApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiMetaCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $ApiMetaCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SpotstockApiResponseImplCopyWith<T, $Res>
    implements $SpotstockApiResponseCopyWith<T, $Res> {
  factory _$$SpotstockApiResponseImplCopyWith(
          _$SpotstockApiResponseImpl<T> value,
          $Res Function(_$SpotstockApiResponseImpl<T>) then) =
      __$$SpotstockApiResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {T data,
      ApiLinks? links,
      ApiMeta? meta,
      String? message,
      bool? success,
      dynamic rawResponse});

  @override
  $ApiLinksCopyWith<$Res>? get links;
  @override
  $ApiMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$SpotstockApiResponseImplCopyWithImpl<T, $Res>
    extends _$SpotstockApiResponseCopyWithImpl<T, $Res,
        _$SpotstockApiResponseImpl<T>>
    implements _$$SpotstockApiResponseImplCopyWith<T, $Res> {
  __$$SpotstockApiResponseImplCopyWithImpl(_$SpotstockApiResponseImpl<T> _value,
      $Res Function(_$SpotstockApiResponseImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of SpotstockApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? links = freezed,
    Object? meta = freezed,
    Object? message = freezed,
    Object? success = freezed,
    Object? rawResponse = freezed,
  }) {
    return _then(_$SpotstockApiResponseImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as ApiLinks?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as ApiMeta?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      rawResponse: freezed == rawResponse
          ? _value.rawResponse
          : rawResponse // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$SpotstockApiResponseImpl<T> implements _SpotstockApiResponse<T> {
  const _$SpotstockApiResponseImpl(
      {required this.data,
      this.links,
      this.meta,
      this.message,
      this.success,
      this.rawResponse});

  factory _$SpotstockApiResponseImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$SpotstockApiResponseImplFromJson(json, fromJsonT);

  @override
  final T data;
  @override
  final ApiLinks? links;
  @override
  final ApiMeta? meta;
  @override
  final String? message;
  @override
  final bool? success;
  @override
  final dynamic rawResponse;

  @override
  String toString() {
    return 'SpotstockApiResponse<$T>(data: $data, links: $links, meta: $meta, message: $message, success: $success, rawResponse: $rawResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotstockApiResponseImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.links, links) || other.links == links) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality()
                .equals(other.rawResponse, rawResponse));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      links,
      meta,
      message,
      success,
      const DeepCollectionEquality().hash(rawResponse));

  /// Create a copy of SpotstockApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotstockApiResponseImplCopyWith<T, _$SpotstockApiResponseImpl<T>>
      get copyWith => __$$SpotstockApiResponseImplCopyWithImpl<T,
          _$SpotstockApiResponseImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$SpotstockApiResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _SpotstockApiResponse<T> implements SpotstockApiResponse<T> {
  const factory _SpotstockApiResponse(
      {required final T data,
      final ApiLinks? links,
      final ApiMeta? meta,
      final String? message,
      final bool? success,
      final dynamic rawResponse}) = _$SpotstockApiResponseImpl<T>;

  factory _SpotstockApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$SpotstockApiResponseImpl<T>.fromJson;

  @override
  T get data;
  @override
  ApiLinks? get links;
  @override
  ApiMeta? get meta;
  @override
  String? get message;
  @override
  bool? get success;
  @override
  dynamic get rawResponse;

  /// Create a copy of SpotstockApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotstockApiResponseImplCopyWith<T, _$SpotstockApiResponseImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

ApiLinks _$ApiLinksFromJson(Map<String, dynamic> json) {
  return _ApiLinks.fromJson(json);
}

/// @nodoc
mixin _$ApiLinks {
  String? get first => throw _privateConstructorUsedError;
  String? get last => throw _privateConstructorUsedError;
  String? get prev => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;

  /// Serializes this ApiLinks to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiLinksCopyWith<ApiLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiLinksCopyWith<$Res> {
  factory $ApiLinksCopyWith(ApiLinks value, $Res Function(ApiLinks) then) =
      _$ApiLinksCopyWithImpl<$Res, ApiLinks>;
  @useResult
  $Res call({String? first, String? last, String? prev, String? next});
}

/// @nodoc
class _$ApiLinksCopyWithImpl<$Res, $Val extends ApiLinks>
    implements $ApiLinksCopyWith<$Res> {
  _$ApiLinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiLinks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? first = freezed,
    Object? last = freezed,
    Object? prev = freezed,
    Object? next = freezed,
  }) {
    return _then(_value.copyWith(
      first: freezed == first
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as String?,
      last: freezed == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as String?,
      prev: freezed == prev
          ? _value.prev
          : prev // ignore: cast_nullable_to_non_nullable
              as String?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiLinksImplCopyWith<$Res>
    implements $ApiLinksCopyWith<$Res> {
  factory _$$ApiLinksImplCopyWith(
          _$ApiLinksImpl value, $Res Function(_$ApiLinksImpl) then) =
      __$$ApiLinksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? first, String? last, String? prev, String? next});
}

/// @nodoc
class __$$ApiLinksImplCopyWithImpl<$Res>
    extends _$ApiLinksCopyWithImpl<$Res, _$ApiLinksImpl>
    implements _$$ApiLinksImplCopyWith<$Res> {
  __$$ApiLinksImplCopyWithImpl(
      _$ApiLinksImpl _value, $Res Function(_$ApiLinksImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiLinks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? first = freezed,
    Object? last = freezed,
    Object? prev = freezed,
    Object? next = freezed,
  }) {
    return _then(_$ApiLinksImpl(
      first: freezed == first
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as String?,
      last: freezed == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as String?,
      prev: freezed == prev
          ? _value.prev
          : prev // ignore: cast_nullable_to_non_nullable
              as String?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiLinksImpl implements _ApiLinks {
  const _$ApiLinksImpl({this.first, this.last, this.prev, this.next});

  factory _$ApiLinksImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiLinksImplFromJson(json);

  @override
  final String? first;
  @override
  final String? last;
  @override
  final String? prev;
  @override
  final String? next;

  @override
  String toString() {
    return 'ApiLinks(first: $first, last: $last, prev: $prev, next: $next)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiLinksImpl &&
            (identical(other.first, first) || other.first == first) &&
            (identical(other.last, last) || other.last == last) &&
            (identical(other.prev, prev) || other.prev == prev) &&
            (identical(other.next, next) || other.next == next));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, first, last, prev, next);

  /// Create a copy of ApiLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiLinksImplCopyWith<_$ApiLinksImpl> get copyWith =>
      __$$ApiLinksImplCopyWithImpl<_$ApiLinksImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiLinksImplToJson(
      this,
    );
  }
}

abstract class _ApiLinks implements ApiLinks {
  const factory _ApiLinks(
      {final String? first,
      final String? last,
      final String? prev,
      final String? next}) = _$ApiLinksImpl;

  factory _ApiLinks.fromJson(Map<String, dynamic> json) =
      _$ApiLinksImpl.fromJson;

  @override
  String? get first;
  @override
  String? get last;
  @override
  String? get prev;
  @override
  String? get next;

  /// Create a copy of ApiLinks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiLinksImplCopyWith<_$ApiLinksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiMeta _$ApiMetaFromJson(Map<String, dynamic> json) {
  return _ApiMeta.fromJson(json);
}

/// @nodoc
mixin _$ApiMeta {
  @JsonKey(name: 'current_page')
  int? get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int? get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int? get perPage => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;

  /// Serializes this ApiMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiMetaCopyWith<ApiMeta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiMetaCopyWith<$Res> {
  factory $ApiMetaCopyWith(ApiMeta value, $Res Function(ApiMeta) then) =
      _$ApiMetaCopyWithImpl<$Res, ApiMeta>;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      @JsonKey(name: 'last_page') int? lastPage,
      @JsonKey(name: 'per_page') int? perPage,
      int? total});
}

/// @nodoc
class _$ApiMetaCopyWithImpl<$Res, $Val extends ApiMeta>
    implements $ApiMetaCopyWith<$Res> {
  _$ApiMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? lastPage = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiMetaImplCopyWith<$Res> implements $ApiMetaCopyWith<$Res> {
  factory _$$ApiMetaImplCopyWith(
          _$ApiMetaImpl value, $Res Function(_$ApiMetaImpl) then) =
      __$$ApiMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      @JsonKey(name: 'last_page') int? lastPage,
      @JsonKey(name: 'per_page') int? perPage,
      int? total});
}

/// @nodoc
class __$$ApiMetaImplCopyWithImpl<$Res>
    extends _$ApiMetaCopyWithImpl<$Res, _$ApiMetaImpl>
    implements _$$ApiMetaImplCopyWith<$Res> {
  __$$ApiMetaImplCopyWithImpl(
      _$ApiMetaImpl _value, $Res Function(_$ApiMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? lastPage = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
  }) {
    return _then(_$ApiMetaImpl(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiMetaImpl implements _ApiMeta {
  const _$ApiMetaImpl(
      {@JsonKey(name: 'current_page') this.currentPage,
      @JsonKey(name: 'last_page') this.lastPage,
      @JsonKey(name: 'per_page') this.perPage,
      this.total});

  factory _$ApiMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiMetaImplFromJson(json);

  @override
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @override
  @JsonKey(name: 'last_page')
  final int? lastPage;
  @override
  @JsonKey(name: 'per_page')
  final int? perPage;
  @override
  final int? total;

  @override
  String toString() {
    return 'ApiMeta(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiMetaImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentPage, lastPage, perPage, total);

  /// Create a copy of ApiMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiMetaImplCopyWith<_$ApiMetaImpl> get copyWith =>
      __$$ApiMetaImplCopyWithImpl<_$ApiMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiMetaImplToJson(
      this,
    );
  }
}

abstract class _ApiMeta implements ApiMeta {
  const factory _ApiMeta(
      {@JsonKey(name: 'current_page') final int? currentPage,
      @JsonKey(name: 'last_page') final int? lastPage,
      @JsonKey(name: 'per_page') final int? perPage,
      final int? total}) = _$ApiMetaImpl;

  factory _ApiMeta.fromJson(Map<String, dynamic> json) = _$ApiMetaImpl.fromJson;

  @override
  @JsonKey(name: 'current_page')
  int? get currentPage;
  @override
  @JsonKey(name: 'last_page')
  int? get lastPage;
  @override
  @JsonKey(name: 'per_page')
  int? get perPage;
  @override
  int? get total;

  /// Create a copy of ApiMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiMetaImplCopyWith<_$ApiMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
