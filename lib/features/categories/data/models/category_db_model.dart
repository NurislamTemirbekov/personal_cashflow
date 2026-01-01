import 'package:cash_flow/core/constants/database_constants.dart';
import 'package:cash_flow/features/categories/model/category_model.dart';
import 'package:cash_flow/features/transactions/model/transaction_model.dart';

class CategoryDbModel {
  final String id;
  final String name;
  final String icon;
  final String type;
  final int createdAtTimestamp;

  CategoryDbModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    required this.createdAtTimestamp,
  });

  factory CategoryDbModel.fromMap(Map<String, dynamic> map) {
    return CategoryDbModel(
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

  CategoryModel toModel() {
    return CategoryModel(
      id: id,
      name: name,
      icon: icon,
      type: type == DatabaseConstants.typeIncome
          ? TransactionType.income
          : TransactionType.expense,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAtTimestamp),
    );
  }

  factory CategoryDbModel.fromModel(CategoryModel model) {
    return CategoryDbModel(
      id: model.id,
      name: model.name,
      icon: model.icon,
      type: model.type == TransactionType.income
          ? DatabaseConstants.typeIncome
          : DatabaseConstants.typeExpense,
      createdAtTimestamp: model.createdAt.millisecondsSinceEpoch,
    );
  }
}



