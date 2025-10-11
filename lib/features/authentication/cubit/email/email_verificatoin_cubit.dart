import 'dart:async';

import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/email/email_verification_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final AuthenticationRepository _auth;
  Timer? _timer;

  EmailVerificationCubit({required AuthenticationRepository authRepository})
    : _auth = authRepository,
      super(EmailVerificationState()) {
    sendEmailVerification();
    setTimerForAutoCheck();
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.sendEmailVerification();
      emit(EmailVerificationState(status: EmailVerificationStatus.sent));
    } catch (e) {
      emit(
        EmailVerificationState(
          status: EmailVerificationStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void setTimerForAutoCheck() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        emit(state.copyWith(status: EmailVerificationStatus.success));
      }
    });
  }

  Future<void> manuallyCheckStatus() async {

    emit(state.copyWith(status: EmailVerificationStatus.loading));

    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user?.emailVerified ?? false) {
      _timer?.cancel(); // Stop the background timer
      emit(state.copyWith(status: EmailVerificationStatus.success));
    } else {
      // If still not verified, go back to the 'sent' state to re-enable the button
      emit(state.copyWith(status: EmailVerificationStatus.sent));
    }
  }
  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
