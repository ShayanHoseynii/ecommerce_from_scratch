import 'package:cwt_starter_template/data/repositories/categories/category_repository.dart';
import 'package:cwt_starter_template/features/shop/cubit/category/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _categoryRepository;
  CategoryCubit(this._categoryRepository) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await _categoryRepository.getAllCategories();
      final featuredCategories = categories.where((cat) => cat.isFeatured && cat.parentId.isEmpty).take(8).toList();

      emit(CategoryLoaded(allCategories: categories, featuredCategories: featuredCategories));
    } catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }
}
