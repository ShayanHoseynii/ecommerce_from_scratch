part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}


final class OrderSuccess extends OrderState {}



final class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  const OrderLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

final class OrderFailure extends OrderState {
  final String error;
  const OrderFailure(this.error);

  @override
  List<Object> get props => [error];
}
