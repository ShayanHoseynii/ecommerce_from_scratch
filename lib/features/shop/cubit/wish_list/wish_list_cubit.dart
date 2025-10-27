// wish_list_cubit.dart
import 'dart:async';

import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/features/shop/cubit/favourite_icon/favourite_icon_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/favourite_icon/favourite_icon_state.dart';
import 'package:cwt_starter_template/features/shop/cubit/wish_list/wish_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final FavouriteProductsCubit _favouriteProductsCubit;
  final ProductRepository _productRepository;
  StreamSubscription? _favouriteSubscription;

  WishlistCubit(this._favouriteProductsCubit, this._productRepository)
    : super(WishlistInitial()) {
    _favouriteSubscription = _favouriteProductsCubit.stream.listen((favState) {
      if (favState is FavouriteProductsLoaded) {
        _refetchProductsFromIds(favState.favourites.keys.toList());
      }
    });
  }

  Future<void> _refetchProductsFromIds(List<String> ids) async {
    try {
      // Only show full loading shimmer if the list isn't already loaded
      if (state is! WishlistLoaded) {
        emit(WishlistLoading());
      }

      final products = await _productRepository.getProductsByIds(ids);
      emit(WishlistLoaded(products: products));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }

  }
    Future<void> fetchWishlistProducts() async {
      try {
        emit(WishlistLoading());

        final favState = _favouriteProductsCubit.state;
        if (favState is FavouriteProductsLoaded) {
          final favouriteIds = favState.favourites.keys.toList();
          final products = await _productRepository.getProductsByIds(
            favouriteIds,
          );

          emit(WishlistLoaded(products: products));
        } else {
          emit(WishlistLoaded(products: []));
        }
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    }

  @override
  Future<void> close() {
    _favouriteSubscription?.cancel();
    return super.close();
  }
}
