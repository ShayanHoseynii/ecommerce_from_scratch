import 'package:equatable/equatable.dart';

enum FormStatus { initial, loading, success, failure, googleSignupSuccess}

class SignupState extends Equatable {
  const SignupState({
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.areTermsAccepted = false,
    this.status = FormStatus.initial,
    this.errorMessage,
  });
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  final String password;

  // UI state
  final bool isPasswordVisible;
  final bool areTermsAccepted;

  // Form submission state
  final FormStatus status;
  final String? errorMessage;

  SignupState copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    String? password,
    bool? isPasswordVisible,
    bool? areTermsAccepted,
    FormStatus? status,
    String? errorMessage,
  }) {
    return SignupState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      areTermsAccepted: areTermsAccepted ?? this.areTermsAccepted,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    username,
    email,
    phoneNumber,
    password,
    isPasswordVisible,
    areTermsAccepted,
    status,
    errorMessage,
  ];
}
