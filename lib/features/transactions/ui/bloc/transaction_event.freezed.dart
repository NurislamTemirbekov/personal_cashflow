// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TransactionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadTransactions,
    required TResult Function(TransactionModel transaction) addTransaction,
    required TResult Function(String transactionId) deleteTransaction,
    required TResult Function(
      String userId,
      DateTime startDate,
      DateTime endDate,
    )
    loadSummary,
    required TResult Function(String userId) refreshTransactions,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadTransactions,
    TResult? Function(TransactionModel transaction)? addTransaction,
    TResult? Function(String transactionId)? deleteTransaction,
    TResult? Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult? Function(String userId)? refreshTransactions,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadTransactions,
    TResult Function(TransactionModel transaction)? addTransaction,
    TResult Function(String transactionId)? deleteTransaction,
    TResult Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult Function(String userId)? refreshTransactions,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_AddTransaction value) addTransaction,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_LoadSummary value) loadSummary,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_AddTransaction value)? addTransaction,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_LoadSummary value)? loadSummary,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_AddTransaction value)? addTransaction,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_LoadSummary value)? loadSummary,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionEventCopyWith<$Res> {
  factory $TransactionEventCopyWith(
    TransactionEvent value,
    $Res Function(TransactionEvent) then,
  ) = _$TransactionEventCopyWithImpl<$Res, TransactionEvent>;
}

/// @nodoc
class _$TransactionEventCopyWithImpl<$Res, $Val extends TransactionEvent>
    implements $TransactionEventCopyWith<$Res> {
  _$TransactionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadTransactionsImplCopyWith<$Res> {
  factory _$$LoadTransactionsImplCopyWith(
    _$LoadTransactionsImpl value,
    $Res Function(_$LoadTransactionsImpl) then,
  ) = __$$LoadTransactionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$LoadTransactionsImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$LoadTransactionsImpl>
    implements _$$LoadTransactionsImplCopyWith<$Res> {
  __$$LoadTransactionsImplCopyWithImpl(
    _$LoadTransactionsImpl _value,
    $Res Function(_$LoadTransactionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$LoadTransactionsImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadTransactionsImpl implements _LoadTransactions {
  const _$LoadTransactionsImpl({required this.userId});

  @override
  final String userId;

  @override
  String toString() {
    return 'TransactionEvent.loadTransactions(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadTransactionsImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadTransactionsImplCopyWith<_$LoadTransactionsImpl> get copyWith =>
      __$$LoadTransactionsImplCopyWithImpl<_$LoadTransactionsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadTransactions,
    required TResult Function(TransactionModel transaction) addTransaction,
    required TResult Function(String transactionId) deleteTransaction,
    required TResult Function(
      String userId,
      DateTime startDate,
      DateTime endDate,
    )
    loadSummary,
    required TResult Function(String userId) refreshTransactions,
  }) {
    return loadTransactions(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadTransactions,
    TResult? Function(TransactionModel transaction)? addTransaction,
    TResult? Function(String transactionId)? deleteTransaction,
    TResult? Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult? Function(String userId)? refreshTransactions,
  }) {
    return loadTransactions?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadTransactions,
    TResult Function(TransactionModel transaction)? addTransaction,
    TResult Function(String transactionId)? deleteTransaction,
    TResult Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult Function(String userId)? refreshTransactions,
    required TResult orElse(),
  }) {
    if (loadTransactions != null) {
      return loadTransactions(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_AddTransaction value) addTransaction,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_LoadSummary value) loadSummary,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
  }) {
    return loadTransactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_AddTransaction value)? addTransaction,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_LoadSummary value)? loadSummary,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
  }) {
    return loadTransactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_AddTransaction value)? addTransaction,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_LoadSummary value)? loadSummary,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    required TResult orElse(),
  }) {
    if (loadTransactions != null) {
      return loadTransactions(this);
    }
    return orElse();
  }
}

abstract class _LoadTransactions implements TransactionEvent {
  const factory _LoadTransactions({required final String userId}) =
      _$LoadTransactionsImpl;

  String get userId;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadTransactionsImplCopyWith<_$LoadTransactionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddTransactionImplCopyWith<$Res> {
  factory _$$AddTransactionImplCopyWith(
    _$AddTransactionImpl value,
    $Res Function(_$AddTransactionImpl) then,
  ) = __$$AddTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransactionModel transaction});

  $TransactionModelCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$AddTransactionImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$AddTransactionImpl>
    implements _$$AddTransactionImplCopyWith<$Res> {
  __$$AddTransactionImplCopyWithImpl(
    _$AddTransactionImpl _value,
    $Res Function(_$AddTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null}) {
    return _then(
      _$AddTransactionImpl(
        transaction: null == transaction
            ? _value.transaction
            : transaction // ignore: cast_nullable_to_non_nullable
                  as TransactionModel,
      ),
    );
  }

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionModelCopyWith<$Res> get transaction {
    return $TransactionModelCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value));
    });
  }
}

/// @nodoc

class _$AddTransactionImpl implements _AddTransaction {
  const _$AddTransactionImpl({required this.transaction});

  @override
  final TransactionModel transaction;

  @override
  String toString() {
    return 'TransactionEvent.addTransaction(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTransactionImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTransactionImplCopyWith<_$AddTransactionImpl> get copyWith =>
      __$$AddTransactionImplCopyWithImpl<_$AddTransactionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadTransactions,
    required TResult Function(TransactionModel transaction) addTransaction,
    required TResult Function(String transactionId) deleteTransaction,
    required TResult Function(
      String userId,
      DateTime startDate,
      DateTime endDate,
    )
    loadSummary,
    required TResult Function(String userId) refreshTransactions,
  }) {
    return addTransaction(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadTransactions,
    TResult? Function(TransactionModel transaction)? addTransaction,
    TResult? Function(String transactionId)? deleteTransaction,
    TResult? Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult? Function(String userId)? refreshTransactions,
  }) {
    return addTransaction?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadTransactions,
    TResult Function(TransactionModel transaction)? addTransaction,
    TResult Function(String transactionId)? deleteTransaction,
    TResult Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult Function(String userId)? refreshTransactions,
    required TResult orElse(),
  }) {
    if (addTransaction != null) {
      return addTransaction(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_AddTransaction value) addTransaction,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_LoadSummary value) loadSummary,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
  }) {
    return addTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_AddTransaction value)? addTransaction,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_LoadSummary value)? loadSummary,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
  }) {
    return addTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_AddTransaction value)? addTransaction,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_LoadSummary value)? loadSummary,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    required TResult orElse(),
  }) {
    if (addTransaction != null) {
      return addTransaction(this);
    }
    return orElse();
  }
}

abstract class _AddTransaction implements TransactionEvent {
  const factory _AddTransaction({required final TransactionModel transaction}) =
      _$AddTransactionImpl;

  TransactionModel get transaction;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTransactionImplCopyWith<_$AddTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTransactionImplCopyWith<$Res> {
  factory _$$DeleteTransactionImplCopyWith(
    _$DeleteTransactionImpl value,
    $Res Function(_$DeleteTransactionImpl) then,
  ) = __$$DeleteTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String transactionId});
}

/// @nodoc
class __$$DeleteTransactionImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$DeleteTransactionImpl>
    implements _$$DeleteTransactionImplCopyWith<$Res> {
  __$$DeleteTransactionImplCopyWithImpl(
    _$DeleteTransactionImpl _value,
    $Res Function(_$DeleteTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transactionId = null}) {
    return _then(
      _$DeleteTransactionImpl(
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteTransactionImpl implements _DeleteTransaction {
  const _$DeleteTransactionImpl({required this.transactionId});

  @override
  final String transactionId;

  @override
  String toString() {
    return 'TransactionEvent.deleteTransaction(transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTransactionImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transactionId);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTransactionImplCopyWith<_$DeleteTransactionImpl> get copyWith =>
      __$$DeleteTransactionImplCopyWithImpl<_$DeleteTransactionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadTransactions,
    required TResult Function(TransactionModel transaction) addTransaction,
    required TResult Function(String transactionId) deleteTransaction,
    required TResult Function(
      String userId,
      DateTime startDate,
      DateTime endDate,
    )
    loadSummary,
    required TResult Function(String userId) refreshTransactions,
  }) {
    return deleteTransaction(transactionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadTransactions,
    TResult? Function(TransactionModel transaction)? addTransaction,
    TResult? Function(String transactionId)? deleteTransaction,
    TResult? Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult? Function(String userId)? refreshTransactions,
  }) {
    return deleteTransaction?.call(transactionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadTransactions,
    TResult Function(TransactionModel transaction)? addTransaction,
    TResult Function(String transactionId)? deleteTransaction,
    TResult Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult Function(String userId)? refreshTransactions,
    required TResult orElse(),
  }) {
    if (deleteTransaction != null) {
      return deleteTransaction(transactionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_AddTransaction value) addTransaction,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_LoadSummary value) loadSummary,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
  }) {
    return deleteTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_AddTransaction value)? addTransaction,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_LoadSummary value)? loadSummary,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
  }) {
    return deleteTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_AddTransaction value)? addTransaction,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_LoadSummary value)? loadSummary,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    required TResult orElse(),
  }) {
    if (deleteTransaction != null) {
      return deleteTransaction(this);
    }
    return orElse();
  }
}

abstract class _DeleteTransaction implements TransactionEvent {
  const factory _DeleteTransaction({required final String transactionId}) =
      _$DeleteTransactionImpl;

  String get transactionId;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteTransactionImplCopyWith<_$DeleteTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadSummaryImplCopyWith<$Res> {
  factory _$$LoadSummaryImplCopyWith(
    _$LoadSummaryImpl value,
    $Res Function(_$LoadSummaryImpl) then,
  ) = __$$LoadSummaryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, DateTime startDate, DateTime endDate});
}

/// @nodoc
class __$$LoadSummaryImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$LoadSummaryImpl>
    implements _$$LoadSummaryImplCopyWith<$Res> {
  __$$LoadSummaryImplCopyWithImpl(
    _$LoadSummaryImpl _value,
    $Res Function(_$LoadSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(
      _$LoadSummaryImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$LoadSummaryImpl implements _LoadSummary {
  const _$LoadSummaryImpl({
    required this.userId,
    required this.startDate,
    required this.endDate,
  });

  @override
  final String userId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'TransactionEvent.loadSummary(userId: $userId, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSummaryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, startDate, endDate);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSummaryImplCopyWith<_$LoadSummaryImpl> get copyWith =>
      __$$LoadSummaryImplCopyWithImpl<_$LoadSummaryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadTransactions,
    required TResult Function(TransactionModel transaction) addTransaction,
    required TResult Function(String transactionId) deleteTransaction,
    required TResult Function(
      String userId,
      DateTime startDate,
      DateTime endDate,
    )
    loadSummary,
    required TResult Function(String userId) refreshTransactions,
  }) {
    return loadSummary(userId, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadTransactions,
    TResult? Function(TransactionModel transaction)? addTransaction,
    TResult? Function(String transactionId)? deleteTransaction,
    TResult? Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult? Function(String userId)? refreshTransactions,
  }) {
    return loadSummary?.call(userId, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadTransactions,
    TResult Function(TransactionModel transaction)? addTransaction,
    TResult Function(String transactionId)? deleteTransaction,
    TResult Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult Function(String userId)? refreshTransactions,
    required TResult orElse(),
  }) {
    if (loadSummary != null) {
      return loadSummary(userId, startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_AddTransaction value) addTransaction,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_LoadSummary value) loadSummary,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
  }) {
    return loadSummary(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_AddTransaction value)? addTransaction,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_LoadSummary value)? loadSummary,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
  }) {
    return loadSummary?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_AddTransaction value)? addTransaction,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_LoadSummary value)? loadSummary,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    required TResult orElse(),
  }) {
    if (loadSummary != null) {
      return loadSummary(this);
    }
    return orElse();
  }
}

abstract class _LoadSummary implements TransactionEvent {
  const factory _LoadSummary({
    required final String userId,
    required final DateTime startDate,
    required final DateTime endDate,
  }) = _$LoadSummaryImpl;

  String get userId;
  DateTime get startDate;
  DateTime get endDate;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSummaryImplCopyWith<_$LoadSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshTransactionsImplCopyWith<$Res> {
  factory _$$RefreshTransactionsImplCopyWith(
    _$RefreshTransactionsImpl value,
    $Res Function(_$RefreshTransactionsImpl) then,
  ) = __$$RefreshTransactionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$RefreshTransactionsImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$RefreshTransactionsImpl>
    implements _$$RefreshTransactionsImplCopyWith<$Res> {
  __$$RefreshTransactionsImplCopyWithImpl(
    _$RefreshTransactionsImpl _value,
    $Res Function(_$RefreshTransactionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$RefreshTransactionsImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RefreshTransactionsImpl implements _RefreshTransactions {
  const _$RefreshTransactionsImpl({required this.userId});

  @override
  final String userId;

  @override
  String toString() {
    return 'TransactionEvent.refreshTransactions(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTransactionsImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshTransactionsImplCopyWith<_$RefreshTransactionsImpl> get copyWith =>
      __$$RefreshTransactionsImplCopyWithImpl<_$RefreshTransactionsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadTransactions,
    required TResult Function(TransactionModel transaction) addTransaction,
    required TResult Function(String transactionId) deleteTransaction,
    required TResult Function(
      String userId,
      DateTime startDate,
      DateTime endDate,
    )
    loadSummary,
    required TResult Function(String userId) refreshTransactions,
  }) {
    return refreshTransactions(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadTransactions,
    TResult? Function(TransactionModel transaction)? addTransaction,
    TResult? Function(String transactionId)? deleteTransaction,
    TResult? Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult? Function(String userId)? refreshTransactions,
  }) {
    return refreshTransactions?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadTransactions,
    TResult Function(TransactionModel transaction)? addTransaction,
    TResult Function(String transactionId)? deleteTransaction,
    TResult Function(String userId, DateTime startDate, DateTime endDate)?
    loadSummary,
    TResult Function(String userId)? refreshTransactions,
    required TResult orElse(),
  }) {
    if (refreshTransactions != null) {
      return refreshTransactions(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_AddTransaction value) addTransaction,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_LoadSummary value) loadSummary,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
  }) {
    return refreshTransactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_AddTransaction value)? addTransaction,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_LoadSummary value)? loadSummary,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
  }) {
    return refreshTransactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_AddTransaction value)? addTransaction,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_LoadSummary value)? loadSummary,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    required TResult orElse(),
  }) {
    if (refreshTransactions != null) {
      return refreshTransactions(this);
    }
    return orElse();
  }
}

abstract class _RefreshTransactions implements TransactionEvent {
  const factory _RefreshTransactions({required final String userId}) =
      _$RefreshTransactionsImpl;

  String get userId;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshTransactionsImplCopyWith<_$RefreshTransactionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
