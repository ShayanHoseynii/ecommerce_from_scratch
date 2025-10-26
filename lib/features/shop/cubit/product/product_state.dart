

import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable{
  const ProductState();

  @override
  List<Object> get props => [];

}



class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final List<ProductModel>? featuredProducts;

  const ProductLoaded({required this.products, required this.featuredProducts});

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}

