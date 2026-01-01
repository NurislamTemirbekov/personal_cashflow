// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CategoryEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCategories,
    required TResult Function() refreshCategories,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCategories,
    TResult? Function()? refreshCategories,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCategories,
    TResult Function()? refreshCategories,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCategories value) loadCategories,
    required TResult Function(_RefreshCategories value) refreshCategories,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCategories value)? loadCategories,
    TResult? Function(_RefreshCategories value)? refreshCategories,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCategories value)? loadCategories,
    TResult Function(_RefreshCategories value)? refreshCategories,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryEventCopyWith<$Res> {
  factory $CategoryEventCopyWith(
    CategoryEvent value,
    $Res Function(CategoryEvent) then,
  ) = _$CategoryEventCopyWithImpl<$Res, CategoryEvent>;
}

/// @nodoc
class _$CategoryEventCopyWithImpl<$Res, $Val extends CategoryEvent>
    implements $CategoryEventCopyWith<$Res> {
  _$CategoryEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadCategoriesImplCopyWith<$Res> {
  factory _$$LoadCategoriesImplCopyWith(
    _$LoadCategoriesImpl value,
    $Res Function(_$LoadCategoriesImpl) then,
  ) = __$$LoadCategoriesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadCategoriesImplCopyWithImpl<$Res>
    extends _$CategoryEventCopyWithImpl<$Res, _$LoadCategoriesImpl>
    implements _$$LoadCategoriesImplCopyWith<$Res> {
  __$$LoadCategoriesImplCopyWithImpl(
    _$LoadCategoriesImpl _value,
    $Res Function(_$LoadCategoriesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadCategoriesImpl implements _LoadCategories {
  const _$LoadCategoriesImpl();

  @override
  String toString() {
    return 'CategoryEvent.loadCategories()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadCategoriesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCategories,
    required TResult Function() refreshCategories,
  }) {
    return loadCategories();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCategories,
    TResult? Function()? refreshCategories,
  }) {
    return loadCategories?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCategories,
    TResult Function()? refreshCategories,
    required TResult orElse(),
  }) {
    if (loadCategories != null) {
      return loadCategories();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCategories value) loadCategories,
    required TResult Function(_RefreshCategories value) refreshCategories,
  }) {
    return loadCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCategories value)? loadCategories,
    TResult? Function(_RefreshCategories value)? refreshCategories,
  }) {
    return loadCategories?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCategories value)? loadCategories,
    TResult Function(_RefreshCategories value)? refreshCategories,
    required TResult orElse(),
  }) {
    if (loadCategories != null) {
      return loadCategories(this);
    }
    return orElse();
  }
}

abstract class _LoadCategories implements CategoryEvent {
  const factory _LoadCategories() = _$LoadCategoriesImpl;
}

/// @nodoc
abstract class _$$RefreshCategoriesImplCopyWith<$Res> {
  factory _$$RefreshCategoriesImplCopyWith(
    _$RefreshCategoriesImpl value,
    $Res Function(_$RefreshCategoriesImpl) then,
  ) = __$$RefreshCategoriesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshCategoriesImplCopyWithImpl<$Res>
    extends _$CategoryEventCopyWithImpl<$Res, _$RefreshCategoriesImpl>
    implements _$$RefreshCategoriesImplCopyWith<$Res> {
  __$$RefreshCategoriesImplCopyWithImpl(
    _$RefreshCategoriesImpl _value,
    $Res Function(_$RefreshCategoriesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshCategoriesImpl implements _RefreshCategories {
  const _$RefreshCategoriesImpl();

  @override
  String toString() {
    return 'CategoryEvent.refreshCategories()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshCategoriesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCategories,
    required TResult Function() refreshCategories,
  }) {
    return refreshCategories();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCategories,
    TResult? Function()? refreshCategories,
  }) {
    return refreshCategories?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCategories,
    TResult Function()? refreshCategories,
    required TResult orElse(),
  }) {
    if (refreshCategories != null) {
      return refreshCategories();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCategories value) loadCategories,
    required TResult Function(_RefreshCategories value) refreshCategories,
  }) {
    return refreshCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCategories value)? loadCategories,
    TResult? Function(_RefreshCategories value)? refreshCategories,
  }) {
    return refreshCategories?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCategories value)? loadCategories,
    TResult Function(_RefreshCategories value)? refreshCategories,
    required TResult orElse(),
  }) {
    if (refreshCategories != null) {
      return refreshCategories(this);
    }
    return orElse();
  }
}

abstract class _RefreshCategories implements CategoryEvent {
  const factory _RefreshCategories() = _$RefreshCategoriesImpl;
}
