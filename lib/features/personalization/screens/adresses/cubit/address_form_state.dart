// lib/features/personalization/cubit/address_form/address_form_state.dart
import 'package:equatable/equatable.dart';

abstract class AddressFormState extends Equatable {
  const AddressFormState();
  @override
  List<Object> get props => [];
}

class AddressFormInitial extends AddressFormState {}

class AddressFormLoading extends AddressFormState {}

class AddressFormSuccess extends AddressFormState {}

class AddressFormFailure extends AddressFormState {
  final String error;
  const AddressFormFailure(this.error);
  @override
  List<Object> get props => [error];
}