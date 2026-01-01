import 'package:cash_flow/features/transactions/model/transaction_model.dart';
import 'package:cash_flow/features/categories/model/category_model.dart';
import 'package:cash_flow/features/auth/model/user_model.dart';
import 'package:cash_flow/features/transactions/model/cash_flow_summary_model.dart';
import 'package:uuid/uuid.dart';

class TestHelpers {
  static const uuid = Uuid();

  static TransactionModel createTransaction({
    String? id,
    double? amount,
    String? description,
    DateTime? date,
    String? categoryId,
    TransactionType? type,
    String? userId,
  }) {
    return TransactionModel(
      id: id ?? uuid.v4(),
      amount: amount ?? 100.0,
      description: description ?? 'Test Transaction',
      date: date ?? DateTime.now(),
      categoryId: categoryId ?? 'test_category',
      type: type ?? TransactionType.expense,
      userId: userId ?? 'test_user',
      createdAt: DateTime.now(),
    );
  }

  static CategoryModel createCategory({
    String? id,
    String? name,
    String? icon,
    TransactionType? type,
  }) {
    return CategoryModel(
      id: id ?? 'test_category',
      name: name ?? 'Test Category',
      icon: icon ?? '💼',
      type: type ?? TransactionType.expense,
      createdAt: DateTime.now(),
    );
  }

  static UserModel createUser({
    String? id,
    String? username,
    String? avatarPath,
  }) {
    return UserModel(
      id: id ?? 'test_user',
      username: username ?? 'testuser',
      avatarPath: avatarPath,
      createdAt: DateTime.now(),
    );
  }

  static CashFlowSummaryModel createCashFlowSummary({
    double? totalIncome,
    double? totalExpenses,
    DateTime? periodStart,
    DateTime? periodEnd,
  }) {
    return CashFlowSummaryModel.create(
      totalIncome: totalIncome ?? 5000.0,
      totalExpenses: totalExpenses ?? 3000.0,
      periodStart: periodStart ?? DateTime(2025, 1, 1),
      periodEnd: periodEnd ?? DateTime(2025, 1, 31),
    );
  }
}

