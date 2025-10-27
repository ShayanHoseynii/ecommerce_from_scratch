import 'package:equatable/equatable.dart';

class FavouriteProductsState extends Equatable {
  const FavouriteProductsState();

  @override
  List<Object> get props => [];
}

class FavouriteProductsLoading extends FavouriteProductsState {}
class FavouriteProductsInitial extends FavouriteProductsState {}

class FavouriteProductsLoaded extends FavouriteProductsState {
  final Map<String, bool> favourites;
  const FavouriteProductsLoaded({required this.favourites});

    @override
  List<Object> get props => [favourites];
}

class FavouriteProductsFailure extends FavouriteProductsState {
    final String error;

  const FavouriteProductsFailure(this.error);

  @override
  List<Object> get props => [error];
}
