class CashFlowSummary {
 CashFlowSummary({
  required this.totalIncome, 
  required this.totalExpenses,
  required this.netFlow,
  required this.periodStart,
  required this.periodEnd,
  });
  final double  totalIncome;
  final double  totalExpenses;
  final double  netFlow;
  final DateTime  periodStart;
  final DateTime periodEnd;

  factory CashFlowSummary.create({
    required double totalIncome,
    required double totalExpenses,
    required DateTime periodStart,
    required DateTime periodEnd,
  }) {
    return CashFlowSummary(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      netFlow: totalIncome - totalExpenses,
      periodStart: periodStart,
      periodEnd: periodStart,
    );
  }
  bool get isPositve => netFlow > 0;
  bool get isNegative => netFlow < 0;
  bool get isBalanced => netFlow == 0;
}