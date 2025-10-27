import 'dart:convert';

import 'package:cwt_starter_template/features/shop/cubit/favourite_icon/favourite_icon_state.dart';
import 'package:cwt_starter_template/utils/local_storage/storage_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteProductsCubit extends Cubit<FavouriteProductsState> {
  FavouriteProductsCubit() : super(FavouriteProductsInitial()) {
    initFavourites();
  }

  void initFavourites() {
    emit(FavouriteProductsLoading());
    try {
      final json = TLocalStorage.instance().readData('favourites');
      if (json != null) {
        final storedFavourites = jsonDecode(json) as Map<String, dynamic>;

        final favourites = storedFavourites.map(
          (key, value) => MapEntry(key, value as bool),
        );

        emit(FavouriteProductsLoaded(favourites: favourites));
      } else {
        emit(FavouriteProductsLoaded(favourites: {}));
      }
    } catch (e) {
      emit(const FavouriteProductsLoaded(favourites: {}));
    }
  }

  bool isFavourite(String productId) {
    final currentState = state;
    if (currentState is FavouriteProductsLoaded) {
      return currentState.favourites[productId] ?? false;
    }
    return false;
  }

  void toggleFavouriteStatus(String productId) {
    final currentState = state;
    if (currentState is FavouriteProductsLoaded) {
      final newFavourites = Map<String, bool>.from(currentState.favourites);
      if (newFavourites.containsKey(productId)) {
        newFavourites.remove(productId);
      } else {
        newFavourites[productId] = true;
      }

      emit(FavouriteProductsLoaded(favourites: newFavourites));
      _saveFavourites(newFavourites);
    }
  }

  Future<void> _saveFavourites(Map<String, bool> favourites) async {
    try {
      // Encode the map to a JSON string
      final json = jsonEncode(favourites);
      // Save it to local storage
      await TLocalStorage.instance().writeData('favourites', json);
    } catch (e) {
      // Handle errors (e.g., storage full)
      print('Error saving favourites: $e');
    }
  }
}
