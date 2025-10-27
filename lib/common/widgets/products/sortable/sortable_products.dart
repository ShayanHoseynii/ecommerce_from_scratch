// t_sortable_products.dart
import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/products/products_card/products_card_vertical.dart';
import 'package:cwt_starter_template/features/shop/cubit/all_products/all_products_cubit.dart';
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Access the cubit
    final cubit = context.read<AllProductsCubit>();

    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField<String>(
          initialValue: 'Name',
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {
            if (value != null) {
              // Call the cubit's sort method
              cubit.sortProducts(value);
            }
          },
          items:
              ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest']
                  .map(
                    (option) =>
                        DropdownMenuItem(value: option, child: Text(option)),
                  )
                  .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Products Grid
        GridLayout(
          itemCount: products.length,
          itemBuilder:
              (_, index) => ProductCardVertical(product: products[index]),
        ),
      ],
    );
  }
}
