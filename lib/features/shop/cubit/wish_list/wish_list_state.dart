
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();
  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductModel> products;
  const WishlistLoaded({this.products = const []});

  @override
  List<Object> get props => [products];
}

class WishlistError extends WishlistState {
  final String message;
  const WishlistError(this.message);

  @override
  List<Object> get props => [message];
}