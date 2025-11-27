import 'package:cash_flow/domain/entities/transaction.dart';

class Category {
  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    required this.createdAt,
  });
  final String id;
  final String name;
  final String icon;
  final TransactionType type;
  final DateTime createdAt ;
  Category copyWith({
    String? id,
    String? name,
    String? icon,
    TransactionType? type,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      createdAt: createdAt ,

    );
  }
  bool get isIncome => type == TransactionType.income;
  bool get isExpense => type == TransactionType.expense;
}