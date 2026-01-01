// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SettingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(String avatarPath) updateAvatar,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(String avatarPath)? updateAvatar,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(String avatarPath)? updateAvatar,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateAvatar value) updateAvatar,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateAvatar value)? updateAvatar,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateAvatar value)? updateAvatar,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsEventCopyWith<$Res> {
  factory $SettingsEventCopyWith(
    SettingsEvent value,
    $Res Function(SettingsEvent) then,
  ) = _$SettingsEventCopyWithImpl<$Res, SettingsEvent>;
}

/// @nodoc
class _$SettingsEventCopyWithImpl<$Res, $Val extends SettingsEvent>
    implements $SettingsEventCopyWith<$Res> {
  _$SettingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadSettingsImplCopyWith<$Res> {
  factory _$$LoadSettingsImplCopyWith(
    _$LoadSettingsImpl value,
    $Res Function(_$LoadSettingsImpl) then,
  ) = __$$LoadSettingsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadSettingsImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$LoadSettingsImpl>
    implements _$$LoadSettingsImplCopyWith<$Res> {
  __$$LoadSettingsImplCopyWithImpl(
    _$LoadSettingsImpl _value,
    $Res Function(_$LoadSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadSettingsImpl implements _LoadSettings {
  const _$LoadSettingsImpl();

  @override
  String toString() {
    return 'SettingsEvent.loadSettings()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadSettingsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(String avatarPath) updateAvatar,
  }) {
    return loadSettings();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(String avatarPath)? updateAvatar,
  }) {
    return loadSettings?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(String avatarPath)? updateAvatar,
    required TResult orElse(),
  }) {
    if (loadSettings != null) {
      return loadSettings();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateAvatar value) updateAvatar,
  }) {
    return loadSettings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateAvatar value)? updateAvatar,
  }) {
    return loadSettings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateAvatar value)? updateAvatar,
    required TResult orElse(),
  }) {
    if (loadSettings != null) {
      return loadSettings(this);
    }
    return orElse();
  }
}

abstract class _LoadSettings implements SettingsEvent {
  const factory _LoadSettings() = _$LoadSettingsImpl;
}

/// @nodoc
abstract class _$$UpdateAvatarImplCopyWith<$Res> {
  factory _$$UpdateAvatarImplCopyWith(
    _$UpdateAvatarImpl value,
    $Res Function(_$UpdateAvatarImpl) then,
  ) = __$$UpdateAvatarImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String avatarPath});
}

/// @nodoc
class __$$UpdateAvatarImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateAvatarImpl>
    implements _$$UpdateAvatarImplCopyWith<$Res> {
  __$$UpdateAvatarImplCopyWithImpl(
    _$UpdateAvatarImpl _value,
    $Res Function(_$UpdateAvatarImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? avatarPath = null}) {
    return _then(
      _$UpdateAvatarImpl(
        avatarPath: null == avatarPath
            ? _value.avatarPath
            : avatarPath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UpdateAvatarImpl implements _UpdateAvatar {
  const _$UpdateAvatarImpl({required this.avatarPath});

  @override
  final String avatarPath;

  @override
  String toString() {
    return 'SettingsEvent.updateAvatar(avatarPath: $avatarPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateAvatarImpl &&
            (identical(other.avatarPath, avatarPath) ||
                other.avatarPath == avatarPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, avatarPath);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateAvatarImplCopyWith<_$UpdateAvatarImpl> get copyWith =>
      __$$UpdateAvatarImplCopyWithImpl<_$UpdateAvatarImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(String avatarPath) updateAvatar,
  }) {
    return updateAvatar(avatarPath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(String avatarPath)? updateAvatar,
  }) {
    return updateAvatar?.call(avatarPath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(String avatarPath)? updateAvatar,
    required TResult orElse(),
  }) {
    if (updateAvatar != null) {
      return updateAvatar(avatarPath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateAvatar value) updateAvatar,
  }) {
    return updateAvatar(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateAvatar value)? updateAvatar,
  }) {
    return updateAvatar?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateAvatar value)? updateAvatar,
    required TResult orElse(),
  }) {
    if (updateAvatar != null) {
      return updateAvatar(this);
    }
    return orElse();
  }
}

abstract class _UpdateAvatar implements SettingsEvent {
  const factory _UpdateAvatar({required final String avatarPath}) =
      _$UpdateAvatarImpl;

  String get avatarPath;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateAvatarImplCopyWith<_$UpdateAvatarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
