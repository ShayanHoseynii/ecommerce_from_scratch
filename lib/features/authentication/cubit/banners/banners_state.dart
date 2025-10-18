import 'package:cwt_starter_template/features/authentication/models/banner_model.dart';
import 'package:equatable/equatable.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  // Unlike categories, you typically just need one list of active banners.
  final List<BannerModel> banners;

  const BannerLoaded(this.banners);

  @override
  List<Object> get props => [banners];
}

class BannerFailure extends BannerState {
  final String error;

  const BannerFailure(this.error);

  @override
  List<Object> get props => [error];
}