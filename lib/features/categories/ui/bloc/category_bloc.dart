import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cash_flow/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:cash_flow/features/categories/ui/bloc/category_event.dart';
import 'package:cash_flow/features/categories/ui/bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  CategoryBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        super(const CategoryState.initial()) {
    on<CategoryEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
    CategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    await event.when(
      loadCategories: () => _onLoadCategories(emit),
      refreshCategories: () => _onRefreshCategories(emit),
    );
  }

  Future<void> _onLoadCategories(Emitter<CategoryState> emit) async {
    emit(const CategoryState.loading());
    try {
      final categories = await _getCategoriesUseCase();
      emit(CategoryState.loaded(categories: categories));
    } catch (e) {
      emit(CategoryState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onRefreshCategories(Emitter<CategoryState> emit) async {
    try {
      final categories = await _getCategoriesUseCase();
      emit(CategoryState.loaded(categories: categories));
    } catch (e) {
      emit(CategoryState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }
}

