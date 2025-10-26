// all_products_screen.dart
import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/products/sortable/sortable_products.dart';
import 'package:cwt_starter_template/features/shop/cubit/all_products/all_products_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/all_products/all_products_state.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/vertical_product_shimmer.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: BlocBuilder<AllProductsCubit, AllProductsState>(
            builder: (context, state) {

              if (state is AllProductsLoading) {
                return const Column(
                  children: [
                    SizedBox(height: 56), 
                    SizedBox(height: TSizes.spaceBtwSections),
                    TVerticalProductShimmer(itemCount: 6,),
                  ],
                );
              }

              if (state is AllProductsError) {
                return Center(child: Text(state.message));
              }

              if (state is AllProductsLoaded) {
                if (state.products.isEmpty) {
                  return Column(
                    children: [
                       DropdownButtonFormField<String>(
                        initialValue: 'Name',
                         decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                         hint: Text('Sort by'),
                         onChanged: (value) => context.read<AllProductsCubit>().sortProducts(value!),
                         items: ['Name', 'Higher Price', 'Lower Price', 'Sale']
                             .map((option) => DropdownMenuItem(value: option, child: Text(option)))
                             .toList(),
                       ),
                       const SizedBox(height: TSizes.spaceBtwSections),
                       const Center(child: Text('No Data Found!')),
                    ],
                  );
                }
                return TSortableProducts(products: state.products);
              }

              return const Center(child: Text('Something went wrong.'));
            },
          ),
        ),
      ),
    );
  }
}