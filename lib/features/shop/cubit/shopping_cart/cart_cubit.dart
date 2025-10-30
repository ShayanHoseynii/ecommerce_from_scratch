// lib/features/shop/cubit/cart/cart_cubit.dart
import 'dart:convert';

import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_state.dart';
import 'package:cwt_starter_template/utils/local_storage/storage_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:cwt_starter_template/features/models/product_variation_model.dart';
import 'package:cwt_starter_template/features/models/cart_item_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    loadCartFromStorage();
  }

  CartLoaded get _currentState {
    if (state is CartLoaded) {
      return state as CartLoaded;
    }
    return const CartLoaded();
  }

  void addToCart({
    required ProductModel product,
    required int quantity,
    ProductVariationModel? selectedVariation,
  }) {
    if (quantity < 1) {
      emit(const CartMessage(type: 'warning', title: 'Select Quantity'));
      return;
    }

    if (product.productType == 'ProductType.variable' &&
        selectedVariation == null) {
      emit(const CartMessage(type: 'warning', title: 'Select Variation'));
      return;
    }

    final int stock = selectedVariation?.stock ?? product.stock;
    if (stock < quantity) {
      emit(
        CartMessage(
          type: 'warning',
          title: 'Oh Snap!',
          message: 'Only $stock items in stock. You cannot add $quantity.',
        ),
      );
      return;
    }

    try {
      final currentItems = List<CartItemModel>.from(_currentState.cartItems);

      final double price =
          selectedVariation != null
              ? (selectedVariation.salePrice > 0
                  ? selectedVariation.salePrice
                  : selectedVariation.price)
              : (product.salePrice > 0 ? product.salePrice : product.price);

      final String cartId =
          selectedVariation != null
              ? '${product.id}_${selectedVariation.id}'
              : product.id;

      final index = currentItems.indexWhere(
        (item) => item.varitaionId == cartId,
      );

      if (index != -1) {
        currentItems[index].quantity += quantity;
      } else {
        final newItem = CartItemModel(
          productId: product.id,
          quantity: quantity,
          varitaionId: cartId,
          image: selectedVariation?.image ?? product.thumbnail,
          price: price,
          title: product.title,
          brandName: product.brand?.name,
          selectedVariation: selectedVariation?.attributeValues,
        );
        currentItems.add(newItem);
      }

      _updateCartState(currentItems);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void _updateCartState(List<CartItemModel> items) {
    double newTotalPrice = 0.0;
    int newTotalItems = 0;

    for (var item in items) {
      newTotalPrice += (item.price * item.quantity);
      newTotalItems += item.quantity;
    }

    final cartItemsStrings = jsonEncode(
      items.map((item) => item.toJson()).toList(),
    );
    TLocalStorage.instance().writeData('cartItems', cartItemsStrings);

    emit(
      CartLoaded(
        cartItems: items,
        totalPrice: newTotalPrice,
        totalItemCount: newTotalItems,
      ),
    );
  }

  void loadCartFromStorage() {
    final jsonString = TLocalStorage.instance().readData('cartItems');

    if (jsonString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(jsonString);

        final List<CartItemModel> cartItems =
            jsonList
                .map(
                  (jsonItem) =>
                      CartItemModel.fromJson(jsonItem as Map<String, dynamic>),
                )
                .toList();

        _updateCartState(cartItems);
      } catch (e) {
        _updateCartState([]);
      }
    } else {
      _updateCartState([]);
    }
  }

  void incrementItem(String cartId) {
    try {
      final items = List<CartItemModel>.from(_currentState.cartItems);
      final index = items.indexWhere((item) => item.varitaionId == cartId);
      if (index == -1) return;

      items[index].quantity++;
      _updateCartState(items);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void decrementItem(String cartId) {
    try {
      final items = List<CartItemModel>.from(_currentState.cartItems);
      final index = items.indexWhere((item) => item.varitaionId == cartId);
      if (index == -1) return;
      if (items[index].quantity > 1) {
        items[index].quantity--;
        _updateCartState(items);
      } else {
        items.removeAt(index);
        _updateCartState(items);
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  int getProductQuantityInCart(String productId) {
    final quantity = _currentState.cartItems
        .where((product) => product.productId == productId)
        .fold(0, (previous, element) => previous + element.quantity);
    return quantity;
  }
}
