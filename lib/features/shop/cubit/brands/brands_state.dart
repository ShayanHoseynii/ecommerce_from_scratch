


import 'package:cwt_starter_template/features/models/brand_model.dart';
import 'package:equatable/equatable.dart';

class BrandsState extends Equatable{
  const BrandsState();

  @override
  List<Object?> get props => [];
}


class BrandsInitial extends BrandsState {}
class BrandsLoading extends BrandsState {}
class BrandsLoaded extends BrandsState {
  final List<BrandModel> allBrands;
  final List<BrandModel> featuredBrands;

  const BrandsLoaded({required this.allBrands, required this.featuredBrands});

  @override
  List<Object?> get props => [allBrands, featuredBrands];
}

class BrandsFailure extends BrandsState {
  final String error;
  const BrandsFailure(this.error);

  @override
  List<Object?> get props => [error];
}