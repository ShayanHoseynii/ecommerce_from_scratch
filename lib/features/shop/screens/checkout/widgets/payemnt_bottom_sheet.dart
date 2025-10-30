

import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/models/payment_model.dart';
import 'package:cwt_starter_template/features/shop/cubit/payment/payment_method_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/payment/payment_method_state.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/widgets/payment_list_tile.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';




class PaymentSelectionSheet extends StatelessWidget {
  const PaymentSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // We wrap the content in a BlocBuilder to get the current state
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        // Get the cubit instance
        final cubit = context.read<PaymentCubit>();
        final selectedMethodName = state.selectedPaymentMethod.name;

        // This is the list of options from your image
        final paymentMethods = [
          PaymentMethodModel(name: 'Paypal', image: TImages.paypal),
          PaymentMethodModel(name: 'Google Pay', image: TImages.googlePay),
          PaymentMethodModel(name: 'Apple Pay', image: TImages.applePay),
          PaymentMethodModel(name: 'VISA', image: TImages.visa),
          PaymentMethodModel(name: 'Master Card', image: TImages.masterCard),
          PaymentMethodModel(name: 'Paytm', image: TImages.paytm),
          PaymentMethodModel(name: 'Paystack', image: TImages.paystack),
          PaymentMethodModel(name: 'Credit Card', image: TImages.creditCard),
        ];

        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TSectionHeading(
                    title: 'Select Payment Method', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Now we build the list dynamically
                ListView.separated(
                  itemCount: paymentMethods.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                  itemBuilder: (context, index) {
                    final method = paymentMethods[index];
                    return TPaymentTile(
                      paymentMethod: method,
                      isSelected: selectedMethodName == method.name,
                      onTap: () {
                        cubit.selectPaymentMethod(method);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),
        );
      },
    );
  }
}