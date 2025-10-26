import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/features/shop/cubit/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;

  ProductCubit(this._productRepository) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getAllProducts();
      final featuredProducts =
          products.where((product) => product.isFeatured!).toList();
      emit(
        ProductLoaded(products: products, featuredProducts: featuredProducts),
      );
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
  Future<void> fetchProductsByCategoryId(String categoryId) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getProductsByCategoryId(categoryId);
      final featuredProducts =
          products.where((product) => product.isFeatured!).toList();
      emit(
        ProductLoaded(products: products, featuredProducts: featuredProducts),
      );
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }


}
