import 'package:cwt_starter_template/common/widgets/products/cart/add_remove_button.dart';
import 'package:cwt_starter_template/common/widgets/products/cart/cart_item.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_price_text.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, required this.showAddRemoveButtons});
  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder:
          (context, index) => Column(
            children: [
              TCartItem(),
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
                        TProductQuantityWithAddRemove(),
                      ],
                    ),
                    TProductPriceText(price: '256'),
                  ],
                ),
            ],
          ),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: TSizes.spaceBtwSections);
      },
    );
  }
}
