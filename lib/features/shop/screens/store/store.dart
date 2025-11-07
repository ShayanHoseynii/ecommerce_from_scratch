import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/appbar/tabbar.dart';
import 'package:cwt_starter_template/common/widgets/brands/brand_card.dart';
import 'package:cwt_starter_template/common/widgets/containers/search_container.dart';
import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/brands_shimmer.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/data/repositories/brands/brands_repository.dart';
import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/features/shop/cubit/brandShowcase/brand_showcase_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/brands/brands_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/brands/brands_state.dart';
import 'package:cwt_starter_template/features/shop/cubit/category/category_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/category/category_state.dart';
import 'package:cwt_starter_template/features/shop/cubit/product/product_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/brands/all_brands.dart';
import 'package:cwt_starter_template/features/shop/screens/cart/cart.dart';
import 'package:cwt_starter_template/features/shop/screens/store/widgets/category_tab.dart';
import 'package:cwt_starter_template/di/injection_container.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, categoryState) {
        if (categoryState is CategoryLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (categoryState is CategoryFailure) {
          return Scaffold(body: Center(child: Text(categoryState.error)));
        }
        if (categoryState is CategoryLoaded) {
          return DefaultTabController(
            length: categoryState.allCategories.length,
            child: Scaffold(
              appBar: TAppBar(
                title: Text(
                  'Store',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                actions: [TCartCounterIcon(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CartScreen())))],
              ),

              body: NestedScrollView(
                headerSliverBuilder: (_, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      floating: true,
                      backgroundColor: dark ? TColors.black : TColors.white,
                      expandedHeight: 440,
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            //// --- Search Bar
                            SizedBox(height: TSizes.spaceBtwItems),
                            TSearchContainer(
                              text: 'Search in Store',
                              showBackground: false,
                              showBorder: true,
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(height: TSizes.spaceBtwSections),

                            /// -- Featured Brands
                            TSectionHeading(
                              title: 'Featured Brands',
                              onPressed:
                                  () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (newContext) => BlocProvider.value(
                                            value: context.read<BrandsCubit>(),
                                            child: const AllBrandsScreen(),
                                          ),
                                    ),
                                  ),
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                            BlocBuilder<BrandsCubit, BrandsState>(
                              builder: (context, state) {
                                if (state is BrandsLoading) {
                                  return TBrandsShimmer(itemCount: 4);
                                } else if (state is BrandsFailure) {
                                  return Center(
                                    child: Text('Error: ${state.error}'),
                                  );
                                } else if (state is BrandsLoaded &&
                                    state.featuredBrands.isEmpty) {
                                  return const Center(
                                    child: Text('No brands available'),
                                  );
                                } else if (state is BrandsLoaded) {
                                  return GridLayout(
                                    mainAxisExtent: 80,
                                    itemCount: state.featuredBrands.length,
                                    itemBuilder: (_, index) {
                                      return BrandCard(
                                        brand: state.featuredBrands[index],
                                        showBorder: true,
                                      );
                                    },
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),

                      bottom: TTabBar(
                        tabs:
                            categoryState.allCategories
                                .map(
                                  (category) => Tab(child: Text(category.name)),
                                )
                                .toList(),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children:
                      categoryState.allCategories.map((category) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(create: (_) => sl<BrandsCubit>()),
                            BlocProvider(create: (_) => sl<ProductCubit>()..fetchProductsByCategoryId(category.id)),
                            BlocProvider(create: (_) => sl<BrandShowcaseCubit>()..loadShowcases(category.id)),
                          ],
                          child: TCategoryTab(category: category,),
                        );
                      }).toList(),
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: Text('Something went wrong')),
        );
      },
    );
  }
}
