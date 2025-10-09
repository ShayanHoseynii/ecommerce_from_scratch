import 'package:cwt_starter_template/data/repositories/authentication/auth_state.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository _repository;

  AuthCubit(this._repository) : super(AuthState.loading);

  Future<void> checkAppStart() async {
    final isFirstTime = await _repository.checkFirstTime();

    if (isFirstTime) {
      emit(AuthState.firstTime);
    } else {
      emit(AuthState.loggedOut);
    }
  }
}