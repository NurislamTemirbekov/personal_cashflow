import 'package:get_it/get_it.dart';
import 'package:cash_flow/features/categories/data/datasources/category_datasource_impl.dart';
import 'package:cash_flow/features/categories/data/repositories/category_repository_impl.dart';
import 'package:cash_flow/features/categories/domain/datasources/category_datasource.dart';
import 'package:cash_flow/features/categories/domain/repositories/category_repository.dart';
import 'package:cash_flow/features/categories/domain/usecases/get_categories_usecase.dart';

void registerCategoryModule(GetIt getIt) {
  getIt.registerLazySingleton<CategoryDatasource>(
    () => CategoryDatasourceImpl(),
  );

  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryDatasource>()),
  );

  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt<CategoryRepository>()),
  );
}



