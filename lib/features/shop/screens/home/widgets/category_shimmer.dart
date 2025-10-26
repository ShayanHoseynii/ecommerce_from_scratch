import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart';
import 'package:cwt_starter_template/features/shop/cubit/category/category_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/category/category_state.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (_, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TShimmerEffect(width: 55, height: 55, radius: 55),
                    SizedBox(height: TSizes.spaceBtwItems / 2),

                    TShimmerEffect(width: 55, height: 8),
                  ],
                ),
              );
            },
            itemCount: 6,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}
