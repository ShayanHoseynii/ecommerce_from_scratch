
import 'package:cwt_starter_template/features/models/cart_item_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartMessage extends CartState {
  final String type; 
  final String title;
  final String message;

  const CartMessage({required this.type, required this.title, this.message = ''});
}
class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  final double totalPrice;
  final int totalItemCount;

  const CartLoaded({
    this.cartItems = const [],
    this.totalPrice = 0.0,
    this.totalItemCount = 0,
  });

  CartLoaded copyWith({
    List<CartItemModel>? cartItems,
    double? totalPrice,
    int? totalItemCount,
  }) {
    return CartLoaded(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      totalItemCount: totalItemCount ?? this.totalItemCount,
    );
  }

  @override
  List<Object> get props => [cartItems, totalPrice, totalItemCount];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);
  @override
  List<Object> get props => [message];
}