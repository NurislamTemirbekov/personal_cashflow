import 'package:cash_flow/features/categories/model/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel?> getCategoryById(String categoryId);
}



