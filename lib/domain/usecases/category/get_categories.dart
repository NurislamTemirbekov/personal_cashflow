import '../../repositories/category_repository.dart';

class GetCategories {
  GetCategories(this._repository);

  final CategoryRepository _repository;

  Future<void> call ()async {
    await _repository.getCategories();
  }
}