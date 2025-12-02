import '../../entities/category.dart';
import '../../repositories/category_repository.dart';

class GetCategories {
  GetCategories(this._repository);

  final CategoryRepository _repository;

  Future<List<Category>> call() async {
    return await _repository.getCategories();
  }
}