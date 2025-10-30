import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_state.dart';
import 'package:cwt_starter_template/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/checkout.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart'; // Import for the icon

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),

      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInitial || state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is CartError) {
             return const Center(child: Text('Something went wrong.'));
          }

          if (state is CartLoaded) {
            if (state.cartItems.isEmpty) {
              return const _EmptyCartWidget();
            } else {
              return const Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: TCartItems(showAddRemoveButtons: true),
              );
            }
          }
          
          return const SizedBox.shrink();
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final isLoaded = state is CartLoaded;
            final totalPrice = isLoaded ? state.totalPrice : 0.0;
            final hasItems = isLoaded && state.cartItems.isNotEmpty;
            return ElevatedButton(
              onPressed: hasItems
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                      );
                    }
                  : null,
              child: Text('Checkout \$${totalPrice.toStringAsFixed(2)}'),
            );
          },
        ),
      ),
    );
  }
}


class _EmptyCartWidget extends StatelessWidget {
  const _EmptyCartWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.shopping_bag, size: 100, color: Colors.grey),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'Oh no, your cart is empty!',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'Looks like you haven\'t added anything to your cart yet. Go ahead and explore our products.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(), 
                child: const Text('Let\'s Go Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}