import 'package:cwt_starter_template/data/repositories/brands/brands_repository.dart';
import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/features/shop/cubit/brandShowcase/brand_showcase_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandShowcaseCubit extends Cubit<BrandShowcaseState> {
  final BrandsRepository _brandRepo;
  final ProductRepository _productRepo;

  BrandShowcaseCubit(this._brandRepo, this._productRepo)
    : super(BrandShowcaseInitial());

  Future<void> loadShowcases(String categoryId) async {
    try {
      emit(BrandShowcaseLoading());

      final brands = await _brandRepo.getBrandsForCategory(categoryId);

      final showcases = await Future.wait(
        brands.map((brand) async {
          final products = await _productRepo.getProductsForBrand(
            brandId: brand.id,
            limit: 3,
          );

          final thumbnails = products.map((p) => p.thumbnail).toList();

          return brand.copyWith(thumbnails: thumbnails,);
        }),
      );

      emit(BrandShowcaseLoaded(showcases));
    } catch (e) {
      emit(BrandShowcaseError(e.toString()));
    }
  }
}
