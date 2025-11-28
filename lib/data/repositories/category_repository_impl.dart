

import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/local/category_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource _dataSource;

  CategoryRepositoryImpl(this._dataSource);

  @override
  Future<List<Category>> getCategories() async {
    final models = await _dataSource.getCategories();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Category?> getCategoryById(String categoryId) async {
    final model = await _dataSource.getCategoryById(categoryId);
    return model?.toEntity();
  }
}
