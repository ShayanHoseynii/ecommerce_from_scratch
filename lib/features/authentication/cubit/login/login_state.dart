



import 'package:equatable/equatable.dart';

enum LoginStatus {initial, loading, success, failure, userNotFound}
class LoginState extends Equatable{
  const LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.isPasswordVisible = false,
    this.rememberMe = false,
    this.error
  });

  final String email;
  final String password;
  final LoginStatus status;
  final String? error;

  final bool isPasswordVisible;
  final bool rememberMe;

 LoginState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? rememberMe,
    LoginStatus? status,
    String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      rememberMe: rememberMe ?? this.rememberMe,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [email, password, isPasswordVisible, rememberMe, status, error];



}