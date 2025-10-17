import 'package:cwt_starter_template/data/models/user_model.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/login/login_state.dart';
import 'package:cwt_starter_template/utils/helpers/networkManager/network_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authRepository;
  final UserRepository _userRepo;
  final localStorage = GetStorage();
  final NetworkCubit _networkCubit;
  LoginCubit({
    required UserRepository userRepo,
    required AuthenticationRepository authRepository,
    required NetworkCubit networkCubit,
  }) : _authRepository = authRepository,
       _networkCubit = networkCubit,
       _userRepo = userRepo,
       super(LoginState()) {
    _loadRememberMeEmail();
  }

  void emailChanged(String value) => emit(state.copyWith(email: value));
  void passwordChanged(String value) => emit(state.copyWith(password: value));
  void togglePasswordVisibility() =>
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  void rememberMeChanged(bool? value) =>
      emit(state.copyWith(rememberMe: value ?? false));

  void _loadRememberMeEmail() {
    final savedEmail = localStorage.read('Remember_Me_Email');
    if (savedEmail != null) {
      emit(state.copyWith(email: savedEmail, rememberMe: true));
    }
  }

  Future<void> emailPasswordSignIn() async {
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
      if (state.rememberMe) {
        localStorage.write('Remember_Me_Email', state.email.trim());
      } else {
        localStorage.remove('Remember_Me_Email');
      }

      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, error: e.toString()));
    }
  }

  Future<void> signUpWithGoogle() async {
    // 1. Check for internet connection
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

    // 2. Start loading
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      // 3. Trigger Google Sign-In and get the user credentials
      final userCredential = await _authRepository.signInWithGoogle();

      if (userCredential == null) {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            error: 'Google sign-in was cancelled.',
          ),
        );
        return;
      }

      // 4. Check if this is a genuinely new user
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        // 5. Create a UserModel from the Google account information
        final user = userCredential.user!;
        final nameParts = UserModel.nameParts(user.displayName ?? '');

        final newUser = UserModel(
          id: user.uid,
          firstName: nameParts.isNotEmpty ? nameParts[0] : '',
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: UserModel.generateUsername(user.displayName ?? ''),
          email: user.email ?? '',
          phoneNumber: user.phoneNumber ?? '',
          profilePicture: user.photoURL ?? '',
        );

        // 6. Save the new user's data to Firestore
        await _userRepo.saveUserData(newUser);
      }
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      // On failure
      emit(state.copyWith(status: LoginStatus.failure, error: e.toString()));
    }
  }
}
