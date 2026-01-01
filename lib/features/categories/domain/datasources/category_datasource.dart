import 'package:cash_flow/features/categories/data/models/category_db_model.dart';

abstract class CategoryDatasource {
  Future<List<CategoryDbModel>> getCategories();
  Future<CategoryDbModel?> getCategoryById(String categoryId);
}



