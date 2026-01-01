import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cash_flow/features/transactions/model/transaction_model.dart';

part 'category_model.freezed.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String name,
    required String icon,
    required TransactionType type,
    required DateTime createdAt,
  }) = _CategoryModel;
}

extension CategoryModelX on CategoryModel {
  bool get isIncome => type == TransactionType.income;
  bool get isExpense => type == TransactionType.expense;
}

