import 'package:cwt_starter_template/data/repositories/brands/brands_repository.dart';
import 'package:cwt_starter_template/features/models/brand_model.dart';
import 'package:cwt_starter_template/features/shop/cubit/brands/brands_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandsCubit extends Cubit<BrandsState> {
  final BrandsRepository _brandsRepository;
  BrandsCubit(this._brandsRepository) : super(BrandsInitial());

  Future<void> fetchBrands() async {
    emit(BrandsLoading());
    try {
      final allBrands = await _brandsRepository.getAllBrands();
      final featuredBrands = allBrands
          .where((brand) => brand.isFeatured)
          .take(4);
      emit(
        BrandsLoaded(
          allBrands: allBrands,
          featuredBrands: featuredBrands.toList(),
        ),
      );
    } catch (e) {
      emit(BrandsFailure(e.toString()));
    }
  }

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await _brandsRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      return [];
    }
  }
}
