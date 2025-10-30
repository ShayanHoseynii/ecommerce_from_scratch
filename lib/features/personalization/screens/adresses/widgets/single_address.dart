import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/features/models/address_model.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.selectedAddress,
    required this.onTap,
    required this.address,
  });

  final bool selectedAddress;
  final VoidCallback onTap;
  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        showBorder: true,
        width: double.infinity,
        backgroundColor:
            selectedAddress
                ? TColors.primary.withOpacity(0.5)
                : Colors.transparent,
        borderColor:
            selectedAddress
                ? Colors.transparent
                : dark
                ? TColors.darkerGrey
                : TColors.grey,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        padding: const EdgeInsets.all(TSizes.md),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 5,
              child: Icon(
                selectedAddress ? Iconsax.tick_circle5 : null,
                color:
                    selectedAddress
                        ? (dark ? TColors.lightContainer : TColors.dark)
                        : null,
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  address.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Text(
                  address.phoneNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                Text(address.toString(), softWrap: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
