import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/features/authentication/cubit/all_products/all_products_state.dart';
import 'package:cwt_starter_template/features/authentication/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  final ProductRepository _productRepository;
  AllProductsCubit(this._productRepository) : super(AllProductsInitial());

  Future<void> fetchAllProducts() async {
    emit(AllProductsLoading());
    try {
      final products = await _productRepository.getAllProducts();
      emit(AllProductsLoaded(products: products));
    } catch (e) {
      emit(AllProductsError(message: e.toString()));
    }
  }

  Future<void> fetchProducts(Query? query) async {
    emit(AllProductsLoading());
    try {
      final List<ProductModel> products;

      if (query == null) {
        // If no query is provided, fetch all products
        products = await _productRepository.getAllProducts();
      } else {
        // If a query is provided, use it
        products = await _productRepository.fetchProductByQuery(query);
      }

      emit(AllProductsLoaded(products: products));
    } catch (e) {
      emit(AllProductsError(message: e.toString()));
    }
  }

  Future<void> fetchFeaturedProducts() async {
    emit(AllProductsLoading());
    try {
      final products = await _productRepository.getFeaturedProducts();
      emit(AllProductsLoaded(products: products));
    } catch (e) {
      emit(AllProductsError(message: e.toString()));
    }
  }

  void sortProducts(String sortOption) {
    if (state is AllProductsLoaded) {
      final currentState = state as AllProductsLoaded;
      final List<ProductModel> sortedProducts = List.from(
        currentState.products,
      );

      switch (sortOption) {
        case 'Name':
          sortedProducts.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'Higher Price':
          sortedProducts.sort(
            (a, b) => b.effectivePrice.compareTo(a.effectivePrice),
          );
          break;
        case 'Lower Price':
          sortedProducts.sort(
            (a, b) => a.effectivePrice.compareTo(b.effectivePrice),
          );
          break;
        case 'Newest':
          // Assuming ProductModel has a 'dateAdded' field of type DateTime
          sortedProducts.sort((a, b) => b.date!.compareTo(a.date!));
          break;

       case 'Sale':
        // Sort items with any sale price first, then by effective price
        sortedProducts.sort((a, b) {
          final aHasSale = a.salePrice > 0 || (a.productVariations?.any((v) => v.salePrice > 0) ?? false);
          final bHasSale = b.salePrice > 0 || (b.productVariations?.any((v) => v.salePrice > 0) ?? false);

          if (aHasSale && !bHasSale) return -1; // a comes first
          if (!aHasSale && bHasSale) return 1;  // b comes first
          
          // If both have/don't have sales, sort by effective price (lowest first)
          return a.effectivePrice.compareTo(b.effectivePrice);
        });
        break;
        // Add cases for 'Newest', 'Popularity' if needed (might require different data/logic)
        default:
          // Optionally handle default case, maybe sort by name?
          sortedProducts.sort((a, b) => a.title.compareTo(b.title));
      }
      // Emit a NEW state with the sorted list
      emit(AllProductsLoaded(products: sortedProducts));
    }
  }
}
