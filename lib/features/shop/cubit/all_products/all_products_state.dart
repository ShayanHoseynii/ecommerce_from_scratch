



import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:equatable/equatable.dart';

class AllProductsState extends Equatable{
  const AllProductsState();

  @override
  List<Object> get props => [];
}

class AllProductsInitial extends AllProductsState {}
class AllProductsLoading extends AllProductsState {}
class AllProductsLoaded extends AllProductsState {
  final List<ProductModel> products;

  const AllProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}
class AllProductsError extends AllProductsState {
  final String message;

  const AllProductsError({required this.message});

  @override
  List<Object> get props => [message];
}