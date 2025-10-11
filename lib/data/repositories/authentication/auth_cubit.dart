import 'dart:async'; // Import async
import 'package:cwt_starter_template/data/repositories/authentication/auth_state.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository _repository;
  late final StreamSubscription<User?> _authSubscription;

  AuthCubit(this._repository) : super(const AuthState(status: AuthStatus.unknown)) {
    // Subscribe to the authentication stream when the cubit is created
    _authSubscription = _repository.authStateChanges.listen(_onAuthStateChanged);
  }

  /// This private method is called every time the user's auth state changes.
  void _onAuthStateChanged(User? user) async {
    // First, check if it's the user's first time. This logic only runs if the user is not logged in.
    if (user == null) {
      final isFirstTime = await _repository.checkFirstTime();
      if (isFirstTime) {
        emit(const AuthState(status: AuthStatus.firstTime));
      } else {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      }
    } else {
      // User is logged in
      user.reload(); // Refresh user data
      if (user.emailVerified) {
        emit(AuthState(status: AuthStatus.authenticated, user: user));
      } else {
        emit(AuthState(status: AuthStatus.emailVerification, user: user));
      }
    }
  }

  Future<void> signOut() async {
    // The stream will automatically handle the state change after sign-out.
    // We just need to call the method.
    try {
      await _repository.signOut();
    } catch (e) {
      emit(AuthState(status: AuthStatus.authError, errorMessage: e.toString()));
    }
  }

  /// Close the stream subscription when the cubit is closed
  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}