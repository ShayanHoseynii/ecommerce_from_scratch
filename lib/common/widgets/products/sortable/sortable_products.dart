import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/products_card/products_card_vertical.dart';
import 'package:cwt_starter_template/features/authentication/cubit/product/product_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/product/product_state.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/vertical_product_shimmer.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          items:
              [
                    'Name',
                    'Higher Price',
                    'LowerPrice',
                    'Sale',
                    'Newest',
                    'Popularity',
                  ]
                  .map(
                    (option) =>
                        DropdownMenuItem(value: option, child: Text(option)),
                  )
                  .toList(),
          onChanged: (value) {},
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// Products
        BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const TVerticalProductShimmer();
                  } else if (state is ProductError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is ProductLoaded && state.featuredProducts == null) {
                    return const Center(child: Text('No products available'));
                  } else if (state is ProductLoaded) {
                    return GridLayout(
                      itemCount: state.featuredProducts!.length,
                      itemBuilder: (_, index) =>  ProductCardVertical(product: state.featuredProducts![index],),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
      ],
    );
  }
}
