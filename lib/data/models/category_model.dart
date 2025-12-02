import 'package:cash_flow/domain/entities/category.dart';
import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/core/constants/database_constants.dart';

class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final String type;
  final int createdAtTimestamp;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    required this.createdAtTimestamp,
  });

 factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map[DatabaseConstants.columnCategoryId] as String,
      name: map[DatabaseConstants.columnCategoryName] as String,
      icon: map[DatabaseConstants.columnCategoryIcon] as String? ?? '📁',
      type: map[DatabaseConstants.columnCategoryType] as String,
      createdAtTimestamp: map[DatabaseConstants.columnCategoryCreatedAt] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.columnCategoryId: id,
      DatabaseConstants.columnCategoryName: name,
      DatabaseConstants.columnCategoryIcon: icon,
      DatabaseConstants.columnCategoryType: type,
      DatabaseConstants.columnCategoryCreatedAt: createdAtTimestamp,
    };
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      icon: icon,
      type: type == DatabaseConstants.typeIncome
          ? TransactionType.income
          : TransactionType.expense,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAtTimestamp),
    );
  }

  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      icon: category.icon,
      type: category.type == TransactionType.income
          ? DatabaseConstants.typeIncome
          : DatabaseConstants.typeExpense,
      createdAtTimestamp: category.createdAt.millisecondsSinceEpoch,
    );
  }
}
