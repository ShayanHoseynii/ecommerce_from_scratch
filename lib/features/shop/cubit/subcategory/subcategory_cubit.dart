import 'package:cwt_starter_template/data/repositories/categories/category_repository.dart';
import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/features/models/category_model.dart';
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:cwt_starter_template/features/shop/cubit/subcategory/subcategory_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcategoryCubit extends Cubit<SubcategoryState> {
  final CategoryRepository _categoryRepository;
  final ProductRepository _productRepository; // <-- Add ProductRepository
  SubcategoryCubit(this._categoryRepository, this._productRepository)
    : super(SubcategoryInitial());

  Future<void> fetchSubCategories(String parentId) async {
    emit(SubcategoryLoading());
    try {
      final subCategories = await _categoryRepository.getSubCategories(
        parentId,
      );

      if (subCategories.isEmpty) {
        emit(SubcategoryLoaded({}));
      }

      Map<CategoryModel, List<ProductModel>> categoryProductsMap = {};

      for (var sub in subCategories) {
        final products = await _productRepository.getProductsByCategoryId(
          sub.id,
        );
        categoryProductsMap[sub] = products;
      }
      emit(SubcategoryLoaded(categoryProductsMap));
    } catch (e) {
      emit(SubcategoryFailure(e.toString()));
    }
  }
}
