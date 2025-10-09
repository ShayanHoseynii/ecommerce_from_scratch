import 'package:cwt_starter_template/features/authentication/cubit/onboarding/onboarding_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/onboarding/onboarding_state_cubit.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/device/device_utility.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final controller = context.read<OnboardingCubit>();
        final dark = THelperFunctions.isDarkMode(context);
        return Positioned(
          bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
          left: TSizes.defaultSpace,
          child: SmoothPageIndicator(
            count: 3,
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            effect: ExpandingDotsEffect(
              activeDotColor: dark ? TColors.lightGrey : TColors.dark,
              dotHeight: 6,
            ),
          ),
        );
      },
    );
  }
}
