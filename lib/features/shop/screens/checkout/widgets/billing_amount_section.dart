import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_state.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '\$${state.totalPrice}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              /// Shipping Fee
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping Fee',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '\$${TPricingCalculator.calculateShippingCost(state.totalPrice, 'US')}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems / 2),

              /// Shipping Fee
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tax Fee',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '\$${TPricingCalculator.calculateTax(state.totalPrice, 'US')}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems / 2),

              /// Order Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Total',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '\$${TPricingCalculator.calculateTotalPrice(state.totalPrice, 'US').toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
