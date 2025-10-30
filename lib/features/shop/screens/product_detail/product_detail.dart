import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_state.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/cubit/cart_quntity_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/cubit/variation_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/cubit/variation_state.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/widgets/bottom_add_to_cart_widget.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/widgets/product_attributes.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/widgets/product_detail_image_slider.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/widgets/product_meta_data.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/widgets/rating_share_widget.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VariationCubit(product)),
        BlocProvider(create: (context) => QuantityCubit()),
      ],
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartMessage) {
            if (state.type == 'success') {
              TLoaders.successSnackBar(
                context: context,
                title: state.title,
                message: state.message,
              );
            } else if (state.type == 'warning') {
              TLoaders.warningSnackBar(
                context: context,
                title: state.title,
                message: state.message,
              );
            }
          } else if (state is CartError) {
            TLoaders.errorSnackBar(
              context: context,
              title: 'Oh Snap!',
              message: state.message,
            );
          }
        },
        child: Scaffold(
          bottomNavigationBar: TBottomAddToCart(product: product),
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// -- Product Image Slider
                BlocBuilder<VariationCubit, VariationState>(
                  builder: (context, state) {
                    return TProductImageSlider(
                      product: product,
                      allImages: state.allProductImages,
                      selectedImage: state.selectedImageUrl,
                      onImageSelected: (imageUrl) {
                        context.read<VariationCubit>().emit(
                          state.copyWith(selectedImageUrl: imageUrl),
                        );
                      },
                    );
                  },
                ),

                /// -- Product Details
                Padding(
                  padding: const EdgeInsets.only(
                    right: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace,
                  ),
                  child: Column(
                    children: [
                      /// - Rating & Share Button
                      TRatingAndWidget(),

                      /// - Price, Title, Stack, & Brand
                      TProductMetaData(product: product),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// - Attributes
                      if (product.productAttributes != null)
                        if (product.productAttributes!.isNotEmpty) ...[
                          TProductAttributes(product: product),
                          SizedBox(height: TSizes.spaceBtwItems),
                        ],

                      /// - Checkout Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Checkout'),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// - Details
                      TSectionHeading(
                        title: 'Details',
                        showActionButton: false,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      ReadMoreText(
                        product.description ?? '',
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: ' Show more',
                        trimExpandedText: ' Less',
                        moreStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                        lessStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      /// - Rewiews
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TSectionHeading(
                            title: 'Rewiews (199)',
                            showActionButton: false,
                          ),
                          IconButton(
                            onPressed:
                                () =>
                                    Navigator.of(context).pushNamed('/reviews'),
                            icon: Icon(Iconsax.arrow_right_3, size: 18),
                          ),
                        ],
                      ),

                      const SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
