import 'dart:async';
import 'package:cwt_starter_template/data/repositories/authentication/auth_state.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/utils/local_storage/storage_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository _repository;
  StreamSubscription<User?>? _authSubscription;
  bool _splashRemoved = false;

  AuthCubit(this._repository)
    : super(const AuthState(status: AuthStatus.unknown)) {
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
      await TLocalStorage.init(null);

      final isFirstTime = await _repository.checkFirstTime();
      if (isFirstTime) {
        emit(const AuthState(status: AuthStatus.firstTime));
      } else {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      }
    } else {
      await user.reload();
      final freshUser = _repository.currentUser;
      if (freshUser == null) {
        await TLocalStorage.init(null); // Init default storage

        emit(const AuthState(status: AuthStatus.unauthenticated));
        return;
      }
            await TLocalStorage.init(freshUser.uid);


      if (freshUser.emailVerified) {
        emit(AuthState(status: AuthStatus.authenticated, user: freshUser));
      } else {
        emit(AuthState(status: AuthStatus.emailVerification, user: freshUser));
      }
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
