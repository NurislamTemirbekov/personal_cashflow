import 'package:cash_flow/core/constants/database_constants.dart';
import 'package:cash_flow/core/database/database.dart';
import 'package:cash_flow/features/categories/data/models/category_db_model.dart';
import 'package:cash_flow/features/categories/domain/datasources/category_datasource.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDatasourceImpl implements CategoryDatasource {
  CategoryDatasourceImpl();

  Future<Database> get _db async => await AppDatabase.database;

  @override
  Future<List<CategoryDbModel>> getCategories() async {
    final db = await _db;
    final maps = await db.query(DatabaseConstants.tableCategories);
    return maps.map((map) => CategoryDbModel.fromMap(map)).toList();
  }

  @override
  Future<CategoryDbModel?> getCategoryById(String categoryId) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableCategories,
      where: '${DatabaseConstants.columnCategoryId} = ?',
      whereArgs: [categoryId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return CategoryDbModel.fromMap(maps.first);
  }
}

