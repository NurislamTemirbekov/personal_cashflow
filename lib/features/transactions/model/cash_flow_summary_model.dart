import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_flow_summary_model.freezed.dart';

@freezed
class CashFlowSummaryModel with _$CashFlowSummaryModel {
  const factory CashFlowSummaryModel({
    required double totalIncome,
    required double totalExpenses,
    required double netFlow,
    required DateTime periodStart,
    required DateTime periodEnd,
  }) = _CashFlowSummaryModel;

  factory CashFlowSummaryModel.create({
    required double totalIncome,
    required double totalExpenses,
    required DateTime periodStart,
    required DateTime periodEnd,
  }) {
    return CashFlowSummaryModel(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      netFlow: totalIncome - totalExpenses,
      periodStart: periodStart,
      periodEnd: periodEnd,
    );
  }
}

extension CashFlowSummaryModelX on CashFlowSummaryModel {
  bool get isPositive => netFlow > 0;
  bool get isNegative => netFlow < 0;
  bool get isBalanced => netFlow == 0;
}



