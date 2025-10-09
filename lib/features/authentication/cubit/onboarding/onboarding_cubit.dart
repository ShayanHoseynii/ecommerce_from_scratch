import 'package:bloc/bloc.dart';
import 'package:cwt_starter_template/features/authentication/cubit/onboarding/onboarding_state_cubit.dart';
import 'package:cwt_starter_template/features/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final PageController pageController = PageController();

  OnboardingCubit() : super(const OnboardingState(0));

  void updatePageIndicator(int index) {
    emit(OnboardingState(index));
  }

  void dotNavigationClick(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(OnboardingState(index));
  }

  void nextPage(BuildContext context) {
    if (state.currentPage < 2) {
      final next = state.currentPage + 1;
      pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(OnboardingState(next));
    } else {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  void skipPage() {
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(const OnboardingState(2));
  }
}
