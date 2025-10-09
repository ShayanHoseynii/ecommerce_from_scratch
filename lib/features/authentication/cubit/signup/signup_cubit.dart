import 'package:cwt_starter_template/data/models/user_model.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/signup/signup_state.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:cwt_starter_template/utils/popups/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  final NetworkCubit _networkCubit;
  final AuthenticationRepository _authRepository;
  final UserRepository _userRepository;
  SignupCubit({
    required NetworkCubit networkCubit,
    required AuthenticationRepository authRepository,
    required UserRepository userRepository,
  }) : _networkCubit = networkCubit,
       _authRepository = authRepository,
       _userRepository = userRepository,
       super(SignupState());

  void firstNameChanged(String value) => emit(state.copyWith(firstName: value));
  void lastNameChanged(String value) => emit(state.copyWith(lastName: value));
  void usernameChanged(String value) => emit(state.copyWith(username: value));
  void emailChanged(String value) => emit(state.copyWith(email: value));
  void phoneNumberChanged(String value) =>
      emit(state.copyWith(phoneNumber: value));
  void passwordChanged(String value) => emit(state.copyWith(password: value));

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void termsAcceptenceChanged(bool? value) {
    emit(state.copyWith(areTermsAccepted: value ?? false));
  }

  Future<void> signUp() async {
    final isConnected = await _networkCubit.isConnected();
    if (!isConnected) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: 'No internet connection.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormStatus.loading));

    try {
      final userCredential = await _authRepository.registerWithEmailAndPassword(
        state.email.trim(),
        state.password.trim(),
      );

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: state.firstName.trim(),
        lastName: state.lastName.trim(),
        username: state.username.trim(),
        email: state.email.trim(),
        phoneNumber: state.phoneNumber.trim(),
        profilePicture: '', // Default profile picture
      );
      await _userRepository.saveUserData(newUser);

      // On success
      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      // On failure
      emit(
        state.copyWith(status: FormStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
