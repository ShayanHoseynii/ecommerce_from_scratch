import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/common/widgets/products/products_card/products_card_horizontal.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/models/category_model.dart';
import 'package:cwt_starter_template/features/shop/cubit/subcategory/subcategory_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/subcategory/subcategory_state.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text(category.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              TRoundedImage(
                width: double.infinity,
                imageUrl: TImages.promoBanner1,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Sub Categories
              BlocBuilder<SubcategoryCubit, SubcategoryState>(
                builder: (context, state) {
                  if (state is SubcategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SubcategoryFailure) {
                    return Center(child: Text(state.error));
                  }

                  if (state is SubcategoryLoaded) {
                    if (state.categoryProductsMap.isEmpty) {
                      return const Center(
                        child: Text('No Sub-Categories found.'),
                      );
                    }


                    return Column(
                      children: [
                        for (var entry in state.categoryProductsMap.entries)
                          Column(
                            children: [
                              TSectionHeading(
                                title: entry.key.name,
                                onPressed: () {},
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems / 2),

                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  itemCount: entry.value.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (context, index) =>
                                          TProductCardHorizontal(
                                            product: entry.value[index],
                                          ),
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: TSizes.spaceBtwItems,
                                      ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
