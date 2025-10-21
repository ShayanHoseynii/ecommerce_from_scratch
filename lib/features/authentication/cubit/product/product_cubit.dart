import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/features/authentication/cubit/product/product_state.dart';
import 'package:cwt_starter_template/features/authentication/models/product_model.dart';
import 'package:cwt_starter_template/utils/constants/enums.dart';
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
}
