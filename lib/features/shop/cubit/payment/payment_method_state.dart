import 'package:cwt_starter_template/features/models/payment_model.dart';
import 'package:equatable/equatable.dart';

// Your state just needs to hold the selected payment method.
class PaymentState extends Equatable {
  final PaymentMethodModel selectedPaymentMethod;

  const PaymentState(this.selectedPaymentMethod);

  @override
  List<Object> get props => [selectedPaymentMethod];
}