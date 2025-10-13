import 'dart:async';
import 'package:cwt_starter_template/data/models/user_model.dart';
import 'package:cwt_starter_template/data/repositories/authentication/auth_state.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository _repository;
  final UserRepository _userRepository;
  StreamSubscription<User?>? _authSubscription;
  bool _splashRemoved = false;

  AuthCubit(this._repository, this._userRepository)
    : super(const AuthState(status: AuthStatus.unknown)) {
    // Start listening to auth state changes immediately when the cubit is created.
    _authSubscription = _repository.authStateChanges.listen(
      _onAuthStateChanged,
    );
  }

    void _onAuthStateChanged(User? user) async {
    if (!_splashRemoved) {
      _splashRemoved = true;
      FlutterNativeSplash.remove();
    }

    if (user == null) {
      final isFirstTime = await _repository.checkFirstTime();
      if (isFirstTime) {
        emit(const AuthState(status: AuthStatus.firstTime));
      } else {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      }
    } else {
      await _saveNewUserData(user);

      await user.reload();
      final freshUser = _repository.currentUser;
      if (freshUser == null) {
        emit(const AuthState(status: AuthStatus.unauthenticated));
        return;
      }

      if (freshUser.emailVerified) {
        emit(AuthState(status: AuthStatus.authenticated, user: freshUser));
      } else {
        emit(AuthState(status: AuthStatus.emailVerification, user: freshUser));
      }
    }
  }

   Future<void> _saveNewUserData(User user) async {
    try {
      // Check if the user record already exists in Firestore
      final existingUser = await _userRepository.fetchUserRecord(user.uid);
      if (existingUser == null) {
        // This is a new user, so create a UserModel
        final nameParts = UserModel.nameParts(user.displayName ?? '');
        final username = UserModel.generateUsername(user.displayName ?? '');

        final newUser = UserModel(
          id: user.uid,
          firstName: nameParts.isNotEmpty ? nameParts[0] : '',
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: user.email ?? '',
          phoneNumber: user.phoneNumber ?? '',
          profilePicture: user.photoURL ?? '',
        );

        // Save the new user record to Firestore
        await _userRepository.saveUserData(newUser);
      }
    } catch (e) {
      // Log the error but don't block the login flow
      print('Error saving new user data: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _repository.signOut();
    } catch (e) {
      emit(AuthState(status: AuthStatus.authError, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
