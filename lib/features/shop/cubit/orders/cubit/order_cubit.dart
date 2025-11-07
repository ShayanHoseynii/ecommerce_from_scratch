import 'package:bloc/bloc.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/order/order_repository.dart';
import 'package:cwt_starter_template/features/models/order_model.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_state.dart';
import 'package:cwt_starter_template/features/shop/cubit/payment/payment_method_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_state.dart';
import 'package:cwt_starter_template/utils/constants/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository;
  final AddressCubit _addressCubit;
  final PaymentMethodCubit _paymentCubit;
  final CartCubit _cartCubit;
  OrderCubit(
    this._orderRepository,
    this._addressCubit,
    this._paymentCubit,
    this._cartCubit,
  ) : super(OrderInitial());

  Future<void> fetchUserOrders() async {
    emit(OrderLoading());
    try {
      final userOrders = await _orderRepository.fetchUserOrders();
      emit(OrderLoaded(userOrders));
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

  Future<void> processOrder(double totalAmount) async {
    emit(OrderLoading());
    try {
      final userId = AuthenticationRepository.instance.currentUser!.uid;
      final cartState = _cartCubit.state;
      final addressState = _addressCubit.state;
      final paymentState = _paymentCubit.state;

      if (cartState is! CartLoaded || cartState.cartItems.isEmpty) {
        throw 'Your cart is empty. Cannot process order.';
      }
      if (addressState is! AddressLoaded || addressState.addresses.isEmpty) {
        throw 'Please select a shipping address.';
      }

      final items = cartState.cartItems;
      final paymentMethod = paymentState.selectedPaymentMethod;
      final selectedAddress = addressState.addresses.firstWhere(
        (a) => a.id == addressState.selectedAddressId,
      );

      if (userId.isEmpty) return;

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        paymentMethod: paymentMethod.name,
        address: selectedAddress,
        deliveryDate: null,
        status: OrderStatus.pending,
        items: items,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
      );
      await _orderRepository.saveOrder(order, userId);

      _cartCubit.clearCart();

      emit(OrderSuccess());
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
}
