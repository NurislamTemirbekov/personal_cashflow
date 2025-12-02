import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/domain/entities/category.dart';
import 'package:cash_flow/domain/entities/user.dart';
import 'package:cash_flow/domain/entities/cash_flow_summary.dart';
import 'package:uuid/uuid.dart';

class TestHelpers {
  static const uuid = Uuid();

  static Transaction createTransaction({
    String? id,
    double? amount,
    String? description,
    DateTime? date,
    String? categoryId,
    TransactionType? type,
    String? userId,
  }) {
    return Transaction(
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

  static Category createCategory({
    String? id,
    String? name,
    String? icon,
    TransactionType? type,
  }) {
    return Category(
      id: id ?? 'test_category',
      name: name ?? 'Test Category',
      icon: icon ?? '💼',
      type: type ?? TransactionType.expense,
      createdAt: DateTime.now(),
    );
  }

  static User createUser({
    String? id,
    String? username,
    String? avatarPath,
  }) {
    return User(
      id: id ?? 'test_user',
      username: username ?? 'testuser',
      avatarPath: avatarPath,
      createdAt: DateTime.now(),
    );
  }

  static CashFlowSummary createCashFlowSummary({
    double? totalIncome,
    double? totalExpenses,
    DateTime? periodStart,
    DateTime? periodEnd,
  }) {
    return CashFlowSummary.create(
      totalIncome: totalIncome ?? 5000.0,
      totalExpenses: totalExpenses ?? 3000.0,
      periodStart: periodStart ?? DateTime(2025, 1, 1),
      periodEnd: periodEnd ?? DateTime(2025, 1, 31),
    );
  }
}

