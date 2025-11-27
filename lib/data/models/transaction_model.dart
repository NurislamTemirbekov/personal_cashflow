import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/core/constants/database_constants.dart';


class TransactionModel {
  final String id;
  final double amount;
  final String description;
  final int dateTimestamp; 
  final String categoryId;
  final String type; 
  final String userId;
  final int createdAtTimestamp;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.description,
    required this.dateTimestamp,
    required this.categoryId,
    required this.type,
    required this.userId,
    required this.createdAtTimestamp,
  });


  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map[DatabaseConstants.columnTracnsactionId] as String,
      amount: (map[DatabaseConstants.columnAmount] as num).toDouble(),
      description: map[DatabaseConstants.columnDecscription] as String? ?? '',
      dateTimestamp: map[DatabaseConstants.columnDate] as int,
      categoryId: map[DatabaseConstants.columnCategoryId] as String,
      type: map[DatabaseConstants.columnType] as String,
      userId: map[DatabaseConstants.columnTracnsactionUserId] as String,
      createdAtTimestamp: map[DatabaseConstants.columnTransactionCreatedAt] as int,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.columnTracnsactionId: id,
      DatabaseConstants.columnAmount: amount,
      DatabaseConstants.columnDecscription: description,
      DatabaseConstants.columnDate: dateTimestamp,
      DatabaseConstants.columnCategoryId: categoryId,
      DatabaseConstants.columnType: type,
      DatabaseConstants.columnTracnsactionUserId: userId,
      DatabaseConstants.columnTransactionCreatedAt: createdAtTimestamp,
    };
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      amount: amount,
      description: description,
      date: DateTime.fromMillisecondsSinceEpoch(dateTimestamp),
      categoryId: categoryId,
      type: type == DatabaseConstants.typeIncome
          ? TransactionType.income
          : TransactionType.expense,
      userId: userId,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAtTimestamp),
    );
  }

  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      amount: transaction.amount,
      description: transaction.description,
      dateTimestamp: transaction.date.millisecondsSinceEpoch,
      categoryId: transaction.categoryId,
      type: transaction.type == TransactionType.income
          ? DatabaseConstants.typeIncome
          : DatabaseConstants.typeExpense,
      userId: transaction.userId,
      createdAtTimestamp: transaction.createdAt.millisecondsSinceEpoch,
    );
  }
}
