import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cash_flow/features/transactions/model/cash_flow_summary_model.dart';
import 'package:cash_flow/features/transactions/model/transaction_model.dart';

part 'transaction_state.freezed.dart';

@freezed
class TransactionState with _$TransactionState {
  const factory TransactionState.initial() = _Initial;
  const factory TransactionState.loading() = _Loading;
  const factory TransactionState.loaded({
    required List<TransactionModel> transactions,
    CashFlowSummaryModel? summary,
  }) = _Loaded;
  const factory TransactionState.error(String message) = _Error;
}



