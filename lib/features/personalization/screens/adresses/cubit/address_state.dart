import 'package:cwt_starter_template/features/models/address_model.dart';
import 'package:equatable/equatable.dart';

abstract class AddressState extends Equatable {
  const AddressState();
  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> addresses;
  final String selectedAddressId;

  const AddressLoaded(this.addresses, this.selectedAddressId);

  @override
  List<Object> get props => [addresses, selectedAddressId];
}

class AddressFailure extends AddressState {
  final String error;
  const AddressFailure(this.error);
  @override
  List<Object> get props => [error];
}