import 'package:equatable/equatable.dart';

// 1. Create an enum for the different statuses
enum ForgetPasswordStatus { initial, loading, sent, failure, success }

// 2. Create a single state class
class ForgetPasswordState extends Equatable {
  const ForgetPasswordState({
    this.status = ForgetPasswordStatus.initial,
    this.errorMessage,
  });

  final ForgetPasswordStatus status;
  final String? errorMessage;

  ForgetPasswordState copyWith({
    ForgetPasswordStatus? status,
    String? errorMessage,
  }) {
    return ForgetPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}