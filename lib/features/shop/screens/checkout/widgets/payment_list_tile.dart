import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/features/models/payment_model.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TPaymentTile extends StatelessWidget {
  const TPaymentTile({
    super.key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onTap,
  });

  final PaymentMethodModel paymentMethod;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(TSizes.sm),
      showBorder: true,
      borderColor: isSelected
          ? TColors.primary
          : dark
              ? TColors.darkGrey
              : TColors.lightGrey,
      backgroundColor: isSelected ? TColors.primary.withOpacity(0.1) : Colors.transparent,
      // --- End Logic ---
      child: ListTile(
        leading: Image(
          image: AssetImage(paymentMethod.image),
          width: 60,
          height: 40,
          fit: BoxFit.contain,
        ),
        title: Text(paymentMethod.name),
        onTap: onTap,
        trailing: isSelected
            ? const Icon(Iconsax.tick_circle, color: TColors.primary)
            : null,
      ),
    );
  }
}