import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cash_flow/features/transactions/model/transaction_model.dart';

part 'transaction_event.freezed.dart';

@freezed
class TransactionEvent with _$TransactionEvent {
  const factory TransactionEvent.loadTransactions({
    required String userId,
  }) = _LoadTransactions;
  const factory TransactionEvent.addTransaction({
    required TransactionModel transaction,
  }) = _AddTransaction;
  const factory TransactionEvent.deleteTransaction({
    required String transactionId,
  }) = _DeleteTransaction;
  const factory TransactionEvent.loadSummary({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) = _LoadSummary;
  const factory TransactionEvent.refreshTransactions({
    required String userId,
  }) = _RefreshTransactions;
}



