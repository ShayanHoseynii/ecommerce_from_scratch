import 'package:cwt_starter_template/features/authentication/cubit/onboarding_cubit.dart';
import 'package:cwt_starter_template/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:cwt_starter_template/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:cwt_starter_template/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:cwt_starter_template/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const _OnboardingView();
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: cubit.pageController,
            onPageChanged: cubit.updatePageIndicator,
            children: [
              OnboardingPage(
                image: TImages.tOnBoardingImage1,
                title: TTexts.tOnBoardingTitle1,
                subtitle: TTexts.tOnBoardingSubTitle1,
              ),
              OnboardingPage(
                image: TImages.tOnBoardingImage2,
                title: TTexts.tOnBoardingTitle2,
                subtitle: TTexts.tOnBoardingSubTitle2,
              ),
              OnboardingPage(
                image: TImages.tOnBoardingImage3,
                title: TTexts.tOnBoardingTitle3,
                subtitle: TTexts.tOnBoardingSubTitle3,
              ),
            ],
          ),

          // skip button
          OnboardingSkip(),

          // dot indicator
          OnboardingDotNavigation(),

          // circular button
          OnboardingNextButton(),
        ],
      ),
    );
  }
}
