import 'package:cwt_starter_template/common/widgets/products/cart/add_remove_button.dart';
import 'package:cwt_starter_template/common/widgets/products/cart/cart_item.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_price_text.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_state.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, required this.showAddRemoveButtons});
  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final currentItem = state.cartItems[index];
              return Column(
                children: [
                  TCartItem(cartItem: currentItem),
                  if (showAddRemoveButtons)
                    const SizedBox(height: TSizes.spaceBtwItems),
                  if (showAddRemoveButtons)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 70),

                            /// Add Remove Buttons
                            TProductQuantityWithAddRemove(cartItem: currentItem,),
                          ],
                        ),
                        TProductPriceText(price: (currentItem.price * currentItem.quantity).toString()),
                      ],
                    ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: TSizes.spaceBtwSections);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
