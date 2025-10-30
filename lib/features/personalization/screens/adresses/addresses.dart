import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:cwt_starter_template/data/repositories/address/address_repository.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/add_new_address.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_form_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_state.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/widgets/single_address.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class AdressesScreen extends StatelessWidget {
  const AdressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (_) => BlocProvider(
                      create:
                          (context) => AddressFormCubit(
                            context.read<AddressRepository>(),
                          ),
                      child: AddNewAddressScreen(),
                    ),
              ),
            ),
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (state is AddressLoading) {
            return const TListTileShimmer();
          }
          if (state is AddressFailure) {
            return Center(child: Text(state.error));
          }
          if (state is AddressLoaded) {
            if (state.addresses.isEmpty) {
              return const Center(child: Text('No addresses found. Add one!'));
            }
            return Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ListView.separated(
                itemBuilder: (_, index) {
                  final address = state.addresses[index];
                  final isSelected = state.selectedAddressId == address.id;
                  return TSingleAddress(
                    selectedAddress: isSelected,
                    address: address,
                    onTap:
                        () =>
                            context.read<AddressCubit>().selectAddress(address),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 2),
                itemCount: state.addresses.length,
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
