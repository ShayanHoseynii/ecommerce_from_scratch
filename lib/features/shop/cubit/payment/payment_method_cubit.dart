import 'package:cwt_starter_template/features/models/payment_model.dart';
import 'package:cwt_starter_template/features/shop/cubit/payment/payment_method_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit()
      : super(
          PaymentState(
            PaymentMethodModel(name: 'Paypal', image: TImages.paypal),
          ),
        );

  void selectPaymentMethod(PaymentMethodModel newMethod) {
    emit(PaymentState(newMethod));
  }
}