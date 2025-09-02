


import 'package:cwt_starter_template/features/authentication/controllers/onboarding_cubit.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/device/device_utility.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      right: 24,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? TColors.buttonPrimary : Colors.black,
        ),
        onPressed: () => context.read<OnboardingCubit>().nextPage(context),
        child: const Icon(Iconsax.arrow_right_3, color: Colors.white),
      ),
    );
  }
}