import 'package:cwt_starter_template/data/models/user_model.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  UserCubit(this._userRepository) : super(UserInitial());

  Future<void> saveUserData(UserCredential? userCreadentials) async {
    try {
      if (userCreadentials?.user == null) return;

      emit(UserSaving());

      final user = userCreadentials!.user!;
      final nameParts = UserModel.nameParts(user.displayName ?? '');
      final username = UserModel.generateUsername(user.displayName ?? '');

      final userModel = UserModel(
        id: user.uid,
        firstName: nameParts[0],
        lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
        username: username,
        email: user.email ?? '',
        phoneNumber: user.phoneNumber ?? '',
        profilePicture: user.photoURL ?? '',
      );
      await _userRepository.saveUserData(userModel);

      emit(UserSaveSuccess());
    } catch (e) {
      emit(UserSaveFailure(e.toString()));
    }
  }
}
