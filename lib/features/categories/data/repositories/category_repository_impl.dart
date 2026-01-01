import 'package:cash_flow/features/categories/domain/datasources/category_datasource.dart';
import 'package:cash_flow/features/categories/domain/repositories/category_repository.dart';
import 'package:cash_flow/features/categories/model/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource _dataSource;

  CategoryRepositoryImpl(this._dataSource);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final dbModels = await _dataSource.getCategories();
    return dbModels.map((model) => model.toModel()).toList();
  }

  @override
  Future<CategoryModel?> getCategoryById(String categoryId) async {
    final dbModel = await _dataSource.getCategoryById(categoryId);
    return dbModel?.toModel();
  }
}

