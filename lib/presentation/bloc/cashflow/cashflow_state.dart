import 'package:equatable/equatable.dart';
import '../../../../domain/entities/transaction.dart';
import '../../../../domain/entities/cash_flow_summary.dart';

abstract class CashFlowState extends Equatable {
  const CashFlowState();

  @override
  List<Object?> get props => [];
}

class CashFlowInitial extends CashFlowState {
  const CashFlowInitial();
}

class CashFlowLoading extends CashFlowState {
  const CashFlowLoading();
}

class CashFlowLoaded extends CashFlowState {
  final List<Transaction> transactions;
  final CashFlowSummary? summary;

  const CashFlowLoaded({
    required this.transactions,
    this.summary,
  });

  @override
  List<Object?> get props => [transactions, summary];

  CashFlowLoaded copyWith({
    List<Transaction>? transactions,
    CashFlowSummary? summary,
  }) {
    return CashFlowLoaded(
      transactions: transactions ?? this.transactions,
      summary: summary ?? this.summary,
    );
  }
}

class CashFlowError extends CashFlowState {
  final String message;

  const CashFlowError(this.message);

  @override
  List<Object?> get props => [message];
}

