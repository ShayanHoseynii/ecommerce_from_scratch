import 'package:cwt_starter_template/common/widgets/image_text_widgets.dart/vertical_image_text.dart';
import 'package:cwt_starter_template/features/shop/cubit/category/category_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/category/category_state.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/category_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) return const TCategoryShimmer();
        if (state is CategoryLoaded) {
          if (state.featuredCategories.isEmpty) {
            return Center(
              child: Text(
                'No Data Found!',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.apply(color: Colors.white),
              ),
            );
          }
          return SizedBox(
            height: 80,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_ , int index) {
                final category = state.featuredCategories[index];
                return TVerticalImageText(
                  image: category.image,
                  title: category.name,
                  onTap:
                      () => Navigator.of(
                        context,
                      ).pushNamed('/sub-categories', arguments: category),
                );
              },
              itemCount: state.featuredCategories.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
