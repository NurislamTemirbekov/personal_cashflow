enum TransactionType {
  income,
  expense,
}

class Transaction {
  final String id;
  final double amount;
  final String description;
  final DateTime date;
  final String categoryId;
  final TransactionType type;
  final String userId;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.categoryId, 
    required this.type,
    required this.userId,
    required this.createdAt,
  });

  Transaction copyWith({
    String? id,
    double? amount,
    String? description,
    DateTime? date,
    String? categoryId,
    TransactionType? type,
    String? userId,
    DateTime? createdAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      categoryId: categoryId ?? this.categoryId, 
      type: type ?? this.type,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt, 
    );
  }

  bool get isIncome => type == TransactionType.income;
  bool get isExpense => type == TransactionType.expense;
}
