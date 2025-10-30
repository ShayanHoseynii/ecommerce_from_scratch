import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_state.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/widgets/address_selection_bottomsheet.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (state is AddressLoading) {
          return _AddressShimmer();
        }
        if (state is AddressLoaded) {
          final address = state.addresses.firstWhere(
            (element) => element.id == state.selectedAddressId,
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSectionHeading(
                title: 'Shipping Address',
                buttonTitle: 'Change',
                onPressed: () {
                  {
                    showModalBottomSheet(
                      context: context,
                      builder:
                          (_) => BlocProvider.value(
                            value: context.read<AddressCubit>(),
                            child: const AddressSelectionSheet(),
                          ),
                    );
                  }
                },
              ),
              Text(address.name, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.grey, size: 16),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text(
                    address.phoneNumber,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Row(
                children: [
                  const Icon(
                    Icons.location_history,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                      address.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class _AddressShimmer extends StatelessWidget {
  const _AddressShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mimic TSectionHeading (title + button)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TShimmerEffect(width: 120, height: 18), // "Shipping Address"
            TShimmerEffect(width: 60, height: 18), // "Change"
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Mimic Text(address.name)
        TShimmerEffect(width: 150, height: 14),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Mimic Row (Icon + Phone)
        Row(
          children: [
            TShimmerEffect(width: 16, height: 16), // Icon
            const SizedBox(width: TSizes.spaceBtwItems),
            TShimmerEffect(width: 120, height: 12), // Phone
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Mimic Row (Icon + Full Address)
        Row(
          children: [
            TShimmerEffect(width: 16, height: 16), // Icon
            const SizedBox(width: TSizes.spaceBtwItems),
            TShimmerEffect(width: 200, height: 12), // Full Address
          ],
        ),
      ],
    );
  }
}
