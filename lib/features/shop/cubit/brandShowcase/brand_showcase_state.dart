import 'package:cwt_starter_template/features/models/brand_model.dart';

abstract class BrandShowcaseState {}

class BrandShowcaseInitial extends BrandShowcaseState {}

class BrandShowcaseLoading extends BrandShowcaseState {}

class BrandShowcaseLoaded extends BrandShowcaseState {
  final List<BrandModel> showcases;
  BrandShowcaseLoaded(this.showcases);
}

class BrandShowcaseError extends BrandShowcaseState {
  final String message;
  BrandShowcaseError(this.message);
}
