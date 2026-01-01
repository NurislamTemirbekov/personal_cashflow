import 'package:cash_flow/features/categories/domain/repositories/category_repository.dart';
import 'package:cash_flow/features/categories/model/category_model.dart';

class GetCategoriesUseCase {
  GetCategoriesUseCase(this._repository);
  final CategoryRepository _repository;

  Future<List<CategoryModel>> call() async {
    return await _repository.getCategories();
  }
}



