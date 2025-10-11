import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  unknown,       // App is starting
  firstTime,     // User needs onboarding
  unauthenticated, // User is logged out, needs to login
  emailVerification, // User has an account but needs to verify
  authenticated,   // User is fully logged in
  authError,       // An error occurred during the process
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user, // The Firebase User object
    this.errorMessage,
  });

  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, user, errorMessage];
}