import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Image(
              image: AssetImage(
                "assets/images/animations/sammy-line-man-receives-a-mail.png",
              ),
              width: TDeviceUtils.getScreenWidth(context) * 0.6,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'Password Reset Email Sent',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            Text(
              "Your account security is our Priority! We've sent you a Secure Link to Safely Change Your Password and Keep Your Account Protected",
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: Text('Done')),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: () {}, child: Text('Resend Email')),
            ),
          ],
        ),
      ),
    );
  }
}
