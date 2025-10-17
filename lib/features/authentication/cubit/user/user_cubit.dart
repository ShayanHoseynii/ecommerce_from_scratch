import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  final AuthenticationRepository _authRepository;
  UserCubit(this._userRepository, this._authRepository) : super(UserInitial());

  Future<void> fetchUserData() async {
    try {
      emit(UserLoading());
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw 'User not logged in!';

      final user = await _userRepository.fetchUserRecord(userId);
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(const UserFailure('User data not found.'));
      }
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> updateUserData(Map<String, dynamic> data) async {
    try {
      // Use the UserLoading state to show an indicator
      emit(UserLoading());
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw 'User not logged in!';

      await _userRepository.updateUserRecord(userId, data);

      // After a successful update, refetch the data to update the UI
      await fetchUserData();
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      emit(UserLoading());

      final userId = _authRepository.currentUser?.uid;
      if (userId == null) throw 'User not found!';

      final provider = _authRepository.getAuthProvider();

      if (provider == 'google.com') {
        await _authRepository.signInWithGoogle();

        await _userRepository.removeUserRecord(userId);

        await _authRepository.deleteAccount();
      } else if (provider == 'password') {
        emit(UserReAuthenticationRequired());
      }
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> reauthenticateAndDelete(String email, String password) async {
    try {
      emit(UserLoading());
      final userId = _authRepository.currentUser?.uid;
      if (userId == null) throw 'User not found!';
      await _authRepository.reAuthenticateWithEmailAndPassword(email, password);
      await _userRepository.removeUserRecord(userId);
      await _authRepository.deleteAccount();
      emit(UserDeleteSuccess());
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}
