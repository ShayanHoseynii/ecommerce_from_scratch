// lib/features/personalization/cubit/address/address_cubit.dart
import 'package:cwt_starter_template/data/repositories/address/address_repository.dart';
import 'package:cwt_starter_template/features/models/address_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository _addressRepository;

  AddressCubit(this._addressRepository) : super(AddressInitial());

  Future<void> fetchUserAddresses() async {
    try {
      emit(AddressLoading());
      final addresses = await _addressRepository.getAddresses();
      
      // Find the currently selected address (or default to the first one)
      String selectedId = '';
      if (addresses.isNotEmpty) {
        final selected = addresses.firstWhere(
          (addr) => addr.selectedAddress,
          orElse: () => addresses.first,
        );
        selectedId = selected.id;
        // Ensure only one is selected
        await _addressRepository.updateSelectedField(selectedId);
      }
      
      emit(AddressLoaded(addresses, selectedId));
    } catch (e) {
      emit(AddressFailure(e.toString()));
    }
  }

  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {
      if (state is AddressLoaded) {
        final currentState = state as AddressLoaded;
        
        emit(AddressLoaded(currentState.addresses, newSelectedAddress.id));
        
        await _addressRepository.updateSelectedField(newSelectedAddress.id);
      }
    } catch (e) {
      emit(AddressFailure(e.toString()));
    }
  }
}