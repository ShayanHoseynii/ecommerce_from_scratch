import 'package:cwt_starter_template/common/widgets/chips/choice_chip.dart';
import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_price_text.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_title_text.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/cubit/variation_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/cubit/variation_state.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/enums.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // -- Handle Single Product Type (Display attributes as simple text) --
    if (product.productType == ProductType.single.toString()) {
      // Return a simple column of rows showing descriptive attributes
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            product.productAttributes!
                .map(
                  (attribute) => Row(
                    children: [
                      TSectionHeading(
                        title: '${attribute.name!}: ',
                        showActionButton: false,
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Text(
                        attribute.values!.join(', '),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
                .toList(),
      );
    }
    // -- Handle Variable Product Type (Interactive selection) --
    else {
      return BlocBuilder<VariationCubit, VariationState>(
        builder: (context, state) {
          final selectedVariation = state.selectedVariation;

          return Column(
            children: [
              /// -- Selected Attribute Pricing & Description Box --
              // Only show this box if a full variation has been selected
              if (selectedVariation.id.isNotEmpty)
                TRoundedContainer(
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title, Price and Stock Status
                      Row(
                        children: [
                          const TSectionHeading(
                            title: 'Variation',
                            showActionButton: false,
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Price
                                Row(
                                  children: [
                                    const ProductTitleText(
                                      title: 'Price: ',
                                      smallSize: true,
                                    ),
                                    const SizedBox(width: TSizes.spaceBtwItems),

                                    // Strikethrough Price if there's a sale
                                    if (selectedVariation.salePrice > 0)
                                      Text(
                                        '\$${selectedVariation.price}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall!.apply(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    if (selectedVariation.salePrice > 0)
                                      const SizedBox(
                                        width: TSizes.spaceBtwItems,
                                      ),

                                    // Final Price
                                    TProductPriceText(
                                      price:
                                          (selectedVariation.salePrice > 0
                                                  ? selectedVariation.salePrice
                                                  : selectedVariation.price)
                                              .toString(),
                                    ),
                                  ],
                                ),

                                /// Stock
                                Row(
                                  children: [
                                    const ProductTitleText(
                                      title: 'Stock: ',
                                      smallSize: true,
                                    ),
                                    Text(
                                      selectedVariation.stock > 0
                                          ? 'In Stock'
                                          : 'Out of Stock',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      /// Variation Description
                      if (selectedVariation.description != null &&
                          selectedVariation.description!.isNotEmpty)
                        ProductTitleText(
                          title: selectedVariation.description!,
                          smallSize: true,
                          maxLines: 4,
                        ),
                    ],
                  ),
                ),

              if (selectedVariation.id.isNotEmpty)
                const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Attribute Selection Chips --
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    product.productAttributes!.map((attribute) {
                      final availableValues = context
                          .read<VariationCubit>()
                          .getAvailableAttributeValues(
                            product.productVariations!,
                            attribute.name!,
                            state.selectedAttributes,
                          );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TSectionHeading(
                            title: attribute.name ?? '',
                            showActionButton: false,
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                          Wrap(
                            spacing: 8,
                            children:
                                attribute.values!.map((attributeValue) {
                                  final isSelected =
                                      state.selectedAttributes[attribute
                                          .name] ==
                                      attributeValue;
                                  final isAvailable = availableValues.contains(
                                    attributeValue,
                                  );
                                  return TChoiceChip(
                                    text: attributeValue,
                                    selected: isSelected,
                                    onSelected:
                                        isAvailable
                                            ? (selected) {
                                              context
                                                  .read<VariationCubit>()
                                                  .onAttributeSelected(
                                                    product,
                                                    attribute.name ?? '',
                                                    attributeValue,
                                                  );
                                            }
                                            : null,
                                  );
                                }).toList(),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                        ],
                      );
                    }).toList(),
              ),
            ],
          );
        },
      );
    }
  }
}
