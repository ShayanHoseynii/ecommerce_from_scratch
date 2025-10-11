import 'package:equatable/equatable.dart';

// 1. Create an enum for the different statuses
enum EmailVerificationStatus { initial, loading, sent, failure, success }

// 2. Create a single state class
class EmailVerificationState extends Equatable {
  const EmailVerificationState({
    this.status = EmailVerificationStatus.initial,
    this.errorMessage,
  });

  final EmailVerificationStatus status;
  final String? errorMessage;

  EmailVerificationState copyWith({
    EmailVerificationStatus? status,
    String? errorMessage,
  }) {
    return EmailVerificationState(
      status: status ?? this.status,
      errorMessage: errorMessage, // Allow clearing the error
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
