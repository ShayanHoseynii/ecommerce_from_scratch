import 'package:cwt_starter_template/features/models/category_model.dart';
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:equatable/equatable.dart'; // Make sure to extend Equatable

abstract class SubcategoryState extends Equatable {
  const SubcategoryState();
  @override
  List<Object> get props => [];
}

class SubcategoryInitial extends SubcategoryState {}
class SubcategoryLoading extends SubcategoryState {}

class SubcategoryLoaded extends SubcategoryState {
  // Use a Map to link each subcategory to its list of products
  final Map<CategoryModel, List<ProductModel>> categoryProductsMap;

  const SubcategoryLoaded(this.categoryProductsMap);

  @override
  List<Object> get props => [categoryProductsMap];
}

class SubcategoryFailure extends SubcategoryState {
  final String error;
  const SubcategoryFailure(this.error);
  @override
  List<Object> get props => [error];
}