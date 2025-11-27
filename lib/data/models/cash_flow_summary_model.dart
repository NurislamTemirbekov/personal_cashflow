import 'package:cash_flow/domain/entities/cash_flow_summary.dart';

class CashFlowSummaryModel {
  CashFlowSummaryModel({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netFlow,
    required this.periodStartTimestamp,
    required this.periodEndTimestamp,
  });
  final double totalIncome;
  final double totalExpenses;
  final double netFlow;
  final int periodStartTimestamp;
  final int periodEndTimestamp;

  CashFlowSummary toEntity() {
    return CashFlowSummary(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      netFlow: netFlow,
      periodStart: DateTime.fromMillisecondsSinceEpoch(periodStartTimestamp),
      periodEnd: DateTime.fromMillisecondsSinceEpoch(periodEndTimestamp),
    );
  }

  factory CashFlowSummaryModel.fromEntity(CashFlowSummary summary) {
    return CashFlowSummaryModel(
      totalIncome: summary.totalIncome,
      totalExpenses: summary.totalExpenses,
      netFlow: summary.netFlow,
      periodStartTimestamp: summary.periodStart.millisecondsSinceEpoch,
      periodEndTimestamp: summary.periodEnd.millisecondsSinceEpoch,
    );
  }

  factory CashFlowSummaryModel.fromRawValues(Map<String, dynamic> row) {
    return CashFlowSummaryModel(
      totalIncome: row['totalIncome'] as double,
      totalExpenses: row['totalExpenses'] as double,
      netFlow: row['netFlow'] as double,
      periodStartTimestamp: row['periodStartTimestamp'] as int,
      periodEndTimestamp: row['periodEndTimestamp'] as int,
    );
  }
}
