import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.title, required this.image, required this.subtitle});

  final String title, image, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            image: AssetImage(image),
            height: TDeviceUtils.getScreenHeight(context) * 0.6,
            width: TDeviceUtils.getScreenWidth(context) * 0.8,
          ),
      
          SizedBox(height: TSizes.spaceBtwItems),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: TSizes.spaceBtwItems),
      
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
