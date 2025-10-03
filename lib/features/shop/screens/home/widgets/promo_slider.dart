import 'package:carousel_slider/carousel_slider.dart';
import 'package:cwt_starter_template/common/widgets/containers/circular_container.dart';
import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/features/shop/screens/home/controller/Carusoul_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/home/controller/carusoul_state.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key, required this.banners});

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarusoulCubit(),

      child: Builder(
        builder: (context) {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) {
                    context.read<CarusoulCubit>().updatePage(index);
                  },
                ),
                items: banners.map((url) => TRoundedImage(imageUrl: url)).toList(),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              BlocBuilder<CarusoulCubit, CarusoulState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 3; i++)
                        TCircularContainer(
                          width: 20,
                          height: 4,
                          margin: EdgeInsets.only(right: 10),
                          backgroundColor:
                              state.currentPage == i
                                  ? TColors.primary
                                  : TColors.grey,
                        ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
