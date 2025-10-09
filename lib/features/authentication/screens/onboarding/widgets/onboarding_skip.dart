import 'package:cwt_starter_template/features/authentication/cubit/onboarding/onboarding_cubit.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: TDeviceUtils.getAppBarHeight(), right: TSizes.defaultSpace,child: TextButton(onPressed: () => context.read<OnboardingCubit>().skipPage(), child: const Text('skip')));
  }
}