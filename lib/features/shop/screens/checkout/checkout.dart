import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/products/cart/coupon_widget.dart';
import 'package:cwt_starter_template/common/widgets/success_screen/success_screen.dart';
import 'package:cwt_starter_template/data/repositories/order/order_repository.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/orders/cubit/order_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/payment/payment_method_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_state.dart';
import 'package:cwt_starter_template/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:cwt_starter_template/navigation/cubit/navigation_menu__cubit.dart';
import 'package:cwt_starter_template/navigation/navigation_menu.dart';
import 'package:cwt_starter_template/di/injection_container.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/pricing_calculator.dart';
import 'package:cwt_starter_template/utils/popups/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<PaymentMethodCubit>()),
        BlocProvider(create: (_) => sl<OrderCubit>()),
      ],
      child: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderLoading) {
            TFullScreenLoader.openLoadingDialog(
              context,
              'Processing Your Order!',
              TImages.docerAnimation,
            );
          } else if (state is OrderFailure) {
            TFullScreenLoader.stopLoading(context);
            TLoaders.errorSnackBar(
              context: context,
              title: 'Error',
              message: state.error,
            );
          } else if (state is OrderSuccess) {
            TFullScreenLoader.stopLoading(context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => SuccessScreen(
                      image: TImages.successfulPaymentIcon,
                      title: 'Payment Successful!',
                      subtitle: 'Your item will be shipped soon!',
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder:
                                (_) => BlocProvider(
                                  create: (context) => NavigationCubit(),
                                  child: const NavigationMenu(),
                                ),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
              ),
            );
          }
        },
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
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.all(TSizes.md),
                    child: Column(
                      children: [
                        /// Pricing
                        TBillingAmountSection(),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        const Divider(),

                        /// -- Payment Methods
                        TBillingPaymentSection(),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        const Divider(),

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
                final totalPrice = TPricingCalculator.calculateTotalPrice(
                  state.totalPrice,
                  'US',
                );
                return Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, orderState) {
                      return ElevatedButton(
                        onPressed:
                            orderState is OrderLoading
                                ? null
                                : () =>
                                    state.totalPrice > 0
                                        ? {
                                          context
                                              .read<OrderCubit>()
                                              .processOrder(totalPrice),
                                        }
                                        : TLoaders.errorSnackBar(
                                          context: context,
                                          title: 'Empty Cart',
                                          message:
                                              'Add items in the caart in order to proceed',
                                        ),
                        child:
                            orderState is OrderLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : Text(
                                  'Checkout \$${TPricingCalculator.calculateTotalPrice(state.totalPrice, 'US').toStringAsFixed(2)}',
                                ),
                      );
                    },
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
