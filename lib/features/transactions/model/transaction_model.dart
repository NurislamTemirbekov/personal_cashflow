import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';

enum TransactionType {
  income,
  expense,
}

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required double amount,
    required String description,
    required DateTime date,
    required String categoryId,
    required TransactionType type,
    required String userId,
    required DateTime createdAt,
  }) = _TransactionModel;
}

extension TransactionModelX on TransactionModel {
  bool get isIncome => type == TransactionType.income;
  bool get isExpense => type == TransactionType.expense;
}



