import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/forgetPassword/forget_password_state.dart';
import 'package:cwt_starter_template/utils/helpers/networkManager/network_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthenticationRepository _authRepo;
  final NetworkCubit _networkCubit;
  ForgetPasswordCubit({
    required AuthenticationRepository authRepository,
    required NetworkCubit networkCubit,
  }) : _authRepo = authRepository,
       _networkCubit = networkCubit,
       super(ForgetPasswordState(status: ForgetPasswordStatus.initial));

  Future<void> sendPasswordResetEmail(String email) async {
    emit(ForgetPasswordState(status: ForgetPasswordStatus.loading));

    final isConnected = await _networkCubit.isConnected();
    if (!isConnected) {
      emit(
        state.copyWith(
          status: ForgetPasswordStatus.failure,
          errorMessage: 'Please check your Internet connection!',
        ),
      );

      return;
    }

    try {
      await _authRepo.sendPasswordResetEmail(email.trim());
      emit(state.copyWith(status: ForgetPasswordStatus.sent));
    } catch (e) {
      emit(state.copyWith(status: ForgetPasswordStatus.failure));
    }
  }
}
