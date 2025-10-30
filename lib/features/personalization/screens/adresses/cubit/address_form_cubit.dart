// lib/features/personalization/cubit/address_form/address_form_cubit.dart
import 'package:cwt_starter_template/data/repositories/address/address_repository.dart'; // Assuming you have this
import 'package:cwt_starter_template/features/models/address_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'address_form_state.dart';

class AddressFormCubit extends Cubit<AddressFormState> {
  final AddressRepository _addressRepository;

  AddressFormCubit(this._addressRepository) : super(AddressFormInitial());

  Future<void> saveAddress(AddressModel address) async {
    try {
      emit(AddressFormLoading());
      
      // Basic validation (you might add more specific checks)
      if (address.name.isEmpty ||
          address.phoneNumber.isEmpty ||
          address.street.isEmpty ||
          address.city.isEmpty ||
          address.state.isEmpty ||
          address.postalCode.isEmpty ||
          address.country.isEmpty) {
        emit(const AddressFormFailure('Please fill in all required fields.'));
        return; 
      }

      // Call the repository to save the address
      await _addressRepository.addAddress(address);

      emit(AddressFormSuccess());
      
    } catch (e) {
      emit(AddressFormFailure(e.toString()));
    }
  }
}