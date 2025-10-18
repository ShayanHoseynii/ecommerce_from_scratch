import 'package:carousel_slider/carousel_slider.dart';
import 'package:cwt_starter_template/common/widgets/containers/circular_container.dart';
import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart';
import 'package:cwt_starter_template/features/authentication/cubit/banners/banners_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/banners/banners_state.dart';
import 'package:cwt_starter_template/features/shop/screens/home/controller/carusoul_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/home/controller/carusoul_state.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// In TPromoSlider.dart
class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- Carousel Slider ---
        BlocBuilder<BannerCubit, BannerState>(
          builder: (context, bannerState) {
            if (bannerState is BannerLoading) {
              return const TShimmerEffect(width: double.infinity, height: 190);
            }

            if (bannerState is BannerFailure) {
              return Center(child: Text('Error: ${bannerState.error}'));
            }

            if (bannerState is BannerLoaded) {
              if (bannerState.banners.isEmpty) return const SizedBox.shrink();

              return Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      onPageChanged: (index, _) =>
                          context.read<CarusoulCubit>().updatePage(index),
                    ),
                    items: bannerState.banners
                        .map((banner) => TRoundedImage(imageUrl: banner.imageUrl))
                        .toList(),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  BlocBuilder<CarusoulCubit, CarusoulState>(
                    builder: (context, carusoulState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          bannerState.banners.length,
                          (index) => TCircularContainer(
                            width: 20,
                            height: 4,
                            margin: const EdgeInsets.only(right: 10),
                            backgroundColor:
                                carusoulState.currentPage == index
                                    ? TColors.primary
                                    : TColors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
