import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cash_flow/features/categories/model/category_model.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;
  const factory CategoryState.loading() = _Loading;
  const factory CategoryState.loaded({
    required List<CategoryModel> categories,
  }) = _Loaded;
  const factory CategoryState.error(String message) = _Error;
}



