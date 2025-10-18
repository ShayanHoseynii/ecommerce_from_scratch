import 'package:cwt_starter_template/features/authentication/models/category_model.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}



class CategoryInitial extends CategoryState {}
class CategoryLoading extends CategoryState {}
class CategoryLoaded extends CategoryState {
  final List<CategoryModel> featuredCategories;
  final List<CategoryModel> allCategories;

  const CategoryLoaded({
    required this.featuredCategories,
    required this.allCategories,
  });

  @override
  List<Object> get props => [featuredCategories, allCategories];
}
class CategoryFailure extends CategoryState {
  final String error;
  const CategoryFailure(this.error);

  @override
  List<Object> get props => [error];
}


