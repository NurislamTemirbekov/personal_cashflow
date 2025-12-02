import 'package:equatable/equatable.dart';
import '../../../../domain/entities/transaction.dart';

abstract class CashFlowEvent extends Equatable {
  const CashFlowEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactionsEvent extends CashFlowEvent {
  final String userId;

  const LoadTransactionsEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class AddTransactionEvent extends CashFlowEvent {
  final Transaction transaction;

  const AddTransactionEvent({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class DeleteTransactionEvent extends CashFlowEvent {
  final String transactionId;

  const DeleteTransactionEvent({required this.transactionId});

  @override
  List<Object> get props => [transactionId];
}

class LoadSummaryEvent extends CashFlowEvent {
  final String userId;
  final DateTime startDate;
  final DateTime endDate;

  const LoadSummaryEvent({
    required this.userId,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [userId, startDate, endDate];
}

class RefreshTransactionsEvent extends CashFlowEvent {
  final String userId;

  const RefreshTransactionsEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

