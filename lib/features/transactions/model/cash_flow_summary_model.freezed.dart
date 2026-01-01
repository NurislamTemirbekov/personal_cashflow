// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_flow_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CashFlowSummaryModel {
  double get totalIncome => throw _privateConstructorUsedError;
  double get totalExpenses => throw _privateConstructorUsedError;
  double get netFlow => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;

  /// Create a copy of CashFlowSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashFlowSummaryModelCopyWith<CashFlowSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashFlowSummaryModelCopyWith<$Res> {
  factory $CashFlowSummaryModelCopyWith(
    CashFlowSummaryModel value,
    $Res Function(CashFlowSummaryModel) then,
  ) = _$CashFlowSummaryModelCopyWithImpl<$Res, CashFlowSummaryModel>;
  @useResult
  $Res call({
    double totalIncome,
    double totalExpenses,
    double netFlow,
    DateTime periodStart,
    DateTime periodEnd,
  });
}

/// @nodoc
class _$CashFlowSummaryModelCopyWithImpl<
  $Res,
  $Val extends CashFlowSummaryModel
>
    implements $CashFlowSummaryModelCopyWith<$Res> {
  _$CashFlowSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashFlowSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncome = null,
    Object? totalExpenses = null,
    Object? netFlow = null,
    Object? periodStart = null,
    Object? periodEnd = null,
  }) {
    return _then(
      _value.copyWith(
            totalIncome: null == totalIncome
                ? _value.totalIncome
                : totalIncome // ignore: cast_nullable_to_non_nullable
                      as double,
            totalExpenses: null == totalExpenses
                ? _value.totalExpenses
                : totalExpenses // ignore: cast_nullable_to_non_nullable
                      as double,
            netFlow: null == netFlow
                ? _value.netFlow
                : netFlow // ignore: cast_nullable_to_non_nullable
                      as double,
            periodStart: null == periodStart
                ? _value.periodStart
                : periodStart // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            periodEnd: null == periodEnd
                ? _value.periodEnd
                : periodEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CashFlowSummaryModelImplCopyWith<$Res>
    implements $CashFlowSummaryModelCopyWith<$Res> {
  factory _$$CashFlowSummaryModelImplCopyWith(
    _$CashFlowSummaryModelImpl value,
    $Res Function(_$CashFlowSummaryModelImpl) then,
  ) = __$$CashFlowSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double totalIncome,
    double totalExpenses,
    double netFlow,
    DateTime periodStart,
    DateTime periodEnd,
  });
}

/// @nodoc
class __$$CashFlowSummaryModelImplCopyWithImpl<$Res>
    extends _$CashFlowSummaryModelCopyWithImpl<$Res, _$CashFlowSummaryModelImpl>
    implements _$$CashFlowSummaryModelImplCopyWith<$Res> {
  __$$CashFlowSummaryModelImplCopyWithImpl(
    _$CashFlowSummaryModelImpl _value,
    $Res Function(_$CashFlowSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashFlowSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncome = null,
    Object? totalExpenses = null,
    Object? netFlow = null,
    Object? periodStart = null,
    Object? periodEnd = null,
  }) {
    return _then(
      _$CashFlowSummaryModelImpl(
        totalIncome: null == totalIncome
            ? _value.totalIncome
            : totalIncome // ignore: cast_nullable_to_non_nullable
                  as double,
        totalExpenses: null == totalExpenses
            ? _value.totalExpenses
            : totalExpenses // ignore: cast_nullable_to_non_nullable
                  as double,
        netFlow: null == netFlow
            ? _value.netFlow
            : netFlow // ignore: cast_nullable_to_non_nullable
                  as double,
        periodStart: null == periodStart
            ? _value.periodStart
            : periodStart // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        periodEnd: null == periodEnd
            ? _value.periodEnd
            : periodEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$CashFlowSummaryModelImpl implements _CashFlowSummaryModel {
  const _$CashFlowSummaryModelImpl({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netFlow,
    required this.periodStart,
    required this.periodEnd,
  });

  @override
  final double totalIncome;
  @override
  final double totalExpenses;
  @override
  final double netFlow;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;

  @override
  String toString() {
    return 'CashFlowSummaryModel(totalIncome: $totalIncome, totalExpenses: $totalExpenses, netFlow: $netFlow, periodStart: $periodStart, periodEnd: $periodEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashFlowSummaryModelImpl &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.totalExpenses, totalExpenses) ||
                other.totalExpenses == totalExpenses) &&
            (identical(other.netFlow, netFlow) || other.netFlow == netFlow) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalIncome,
    totalExpenses,
    netFlow,
    periodStart,
    periodEnd,
  );

  /// Create a copy of CashFlowSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashFlowSummaryModelImplCopyWith<_$CashFlowSummaryModelImpl>
  get copyWith =>
      __$$CashFlowSummaryModelImplCopyWithImpl<_$CashFlowSummaryModelImpl>(
        this,
        _$identity,
      );
}

abstract class _CashFlowSummaryModel implements CashFlowSummaryModel {
  const factory _CashFlowSummaryModel({
    required final double totalIncome,
    required final double totalExpenses,
    required final double netFlow,
    required final DateTime periodStart,
    required final DateTime periodEnd,
  }) = _$CashFlowSummaryModelImpl;

  @override
  double get totalIncome;
  @override
  double get totalExpenses;
  @override
  double get netFlow;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;

  /// Create a copy of CashFlowSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashFlowSummaryModelImplCopyWith<_$CashFlowSummaryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
