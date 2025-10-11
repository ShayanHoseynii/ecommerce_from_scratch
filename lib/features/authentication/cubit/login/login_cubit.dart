import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/login/login_state.dart';
import 'package:cwt_starter_template/utils/helpers/networkManager/network_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authRepository;
  final NetworkCubit _networkCubit;
  LoginCubit({
    required AuthenticationRepository authRepository,
    required NetworkCubit networkCubit,
  }) : _authRepository = authRepository,
       _networkCubit = networkCubit,
       super(LoginState());

  void emailChanged(String value) => emit(state.copyWith(email: value));
  void passwordChanged(String value) => emit(state.copyWith(password: value));
  void togglePasswordVisibility() =>
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  void rememberMeChanged(bool? value) => emit(state.copyWith(rememberMe: value ?? false));

  Future<void> signIn() async {
    final isConnected = await _networkCubit.isConnected();
    if (!isConnected) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          error: 'No internet connection.',
        ),
      );
      return;
    }
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _authRepository.signInWithEmailAndPassword(
        state.email.trim(),
        state.password.trim(),
      );
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, error: e.toString()));
    }
  }
}
