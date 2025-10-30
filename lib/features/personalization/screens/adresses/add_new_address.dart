import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/features/models/address_model.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_form_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_form_state.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/popups/loaders.dart';
import 'package:cwt_starter_template/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Add New Address',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator:
                      (value) => TValidator.validateEmptyText('Name', value),

                  controller: _nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  validator: (value) => TValidator.validatePhoneNumber(value),

                  controller: _phoneController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _streetController,
                        validator:
                            (value) =>
                                TValidator.validateEmptyText('Street', value),

                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Street',
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),

                    Expanded(
                      child: TextFormField(
                        validator:
                            (value) => TValidator.validateEmptyText(
                              'Postal Code',
                              value,
                            ),

                        controller: _postalCodeController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator:
                            (value) =>
                                TValidator.validateEmptyText('City', value),

                        controller: _cityController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'city',
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),

                    Expanded(
                      child: TextFormField(
                        validator:
                            (value) =>
                                TValidator.validateEmptyText('State', value),

                        controller: _stateController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                TextFormField(
                  validator:
                      (value) => TValidator.validateEmptyText('Country', value),
                  controller: _countryController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                SizedBox(
                  width: double.infinity,
                  child: BlocConsumer<AddressFormCubit, AddressFormState>(
                    listener: (context, state) {
                      if (state is AddressFormSuccess) {
                        TLoaders.successSnackBar(
                          context: context,
                          title: 'Success',
                          message: 'Address saved successfully!',
                        );
                        Navigator.pop(context);
                      } else if (state is AddressFormFailure) {
                        TLoaders.errorSnackBar(
                          context: context,
                          title: 'Error',
                          message: state.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed:
                            state is AddressFormLoading
                                ? null
                                : () {
                                  if (_formKey.currentState!.validate()) {
                                    final newAddress = AddressModel(
                                      id: '',
                                      name: _nameController.text.trim(),
                                      phoneNumber: _phoneController.text.trim(),
                                      street: _streetController.text.trim(),
                                      city: _cityController.text.trim(),
                                      state: _stateController.text.trim(),
                                      postalCode:
                                          _postalCodeController.text.trim(),
                                      country: _countryController.text.trim(),
                                      dateTime: DateTime.now(),
                                      selectedAddress: false,
                                    );

                                    context
                                        .read<AddressFormCubit>()
                                        .saveAddress(newAddress);
                                    context.read<AddressCubit>().fetchUserAddresses();
                                  }
                                },
                        child: state is AddressFormLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Save'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
