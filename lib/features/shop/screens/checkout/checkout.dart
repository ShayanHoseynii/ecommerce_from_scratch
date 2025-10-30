import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/products/cart/coupon_widget.dart';
import 'package:cwt_starter_template/common/widgets/success_screen/success_screen.dart';
import 'package:cwt_starter_template/features/shop/cubit/payment/payment_method_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_state.dart';
import 'package:cwt_starter_template/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Order Reviews',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// -- Items in Cart
                TCartItems(showAddRemoveButtons: false),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// -- Coupon TextField
                TCouponCode(),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// -- Billing & Payment Section
                TRoundedContainer(
                  showBorder: true,
                  padding: EdgeInsets.all(TSizes.md),
                  child: Column(
                    children: [
                      /// Pricing
                      TBillingAmountSection(),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// -- Payment Methods
                      TBillingPaymentSection(),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// Address
                      TBillingAddressSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              return Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ElevatedButton(
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SuccessScreen(
                                image: TImages.successfulPaymentIcon,
                                title: 'Payment Successful!',
                                subtitle: 'Your item will be shipped soon!',
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/navbar',
                                    (route) => false,
                                  );
                                },
                              ),
                        ),
                      ),
                  child: Text('Checkout \$${TPricingCalculator.calculateTotalPrice(state.totalPrice, 'US').toStringAsFixed(2)}'),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
