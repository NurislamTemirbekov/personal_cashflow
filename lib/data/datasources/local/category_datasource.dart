import 'package:cash_flow/core/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/category_model.dart';
import 'database.dart';

class CategoryDatasource {
  CategoryDatasource();

  Future<Database> get _db async => await AppDatabase.database;

  Future<List<CategoryModel>> getCategories() async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableCategories,
      orderBy: '${DatabaseConstants.columnCategoryName} ASC',
    );
    return maps.map((map) => CategoryModel.fromMap(map)).toList();
  }

  Future<List<CategoryModel>> getCategoriesByType(String type) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableCategories,
      where: '${DatabaseConstants.columnCategoryType} = ?',
      whereArgs: [type],
      orderBy: '${DatabaseConstants.columnCategoryName} ASC',
    );
    return maps.map((map) => CategoryModel.fromMap(map)).toList();
  }

  Future<CategoryModel?> getCategoryById(String categoryId) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableCategories,
      where: '${DatabaseConstants.columnCategoryId} = ?',
      whereArgs: [categoryId],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return CategoryModel.fromMap(maps.first);
    }
    return null;
  }
}
