import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}


class UserInitial extends UserState {}

class UserSaving extends UserState {}

class UserSaveSuccess extends UserState {}

class UserSaveFailure extends UserState {
  final String error;

  const UserSaveFailure(this.error);

  @override
  List<Object> get props => [error];
}