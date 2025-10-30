import 'package:cwt_starter_template/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/data/repositories/address/address_repository.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/add_new_address.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_form_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_state.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/widgets/single_address.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class AddressSelectionSheet extends StatelessWidget {
  const AddressSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TSectionHeading(
              title: 'Select Address',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                ),
                side: const BorderSide(color: Colors.grey),
                padding: const EdgeInsets.symmetric(vertical: TSizes.md),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => BlocProvider(
                          create:
                              (context) => AddressFormCubit(
                                context.read<AddressRepository>(),
                              ),
                          child: const AddNewAddressScreen(),
                        ),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.add),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Text('Add New Address'),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            BlocBuilder<AddressCubit, AddressState>(
              builder: (context, state) {
                if (state is AddressLoading) {
                  return const TListTileShimmer();
                }
                if (state is AddressFailure) {
                  return Center(child: Text(state.error));
                }
                if (state is AddressLoaded) {
                  if (state.addresses.isEmpty) {
                    return const Center(child: Text('No addresses found.'));
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.addresses.length,
                    separatorBuilder:
                        (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
                    itemBuilder: (context, index) {
                      final address = state.addresses[index];
                      final isSelected = state.selectedAddressId == address.id;
                      return TSingleAddress(
                        address: address,
                        selectedAddress: isSelected,
                        onTap: () {
                          context.read<AddressCubit>().selectAddress(address);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                }
                return const Center(child: Text('data'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
