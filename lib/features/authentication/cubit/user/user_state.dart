
import 'package:cwt_starter_template/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserReAuthenticationRequired extends UserState {}
class UserDeleteSuccess extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;
  const UserLoaded(this.user);



  @override
  List<Object> get props => [user];
}



class UserFailure extends UserState {
  final String error;
  const UserFailure(this.error);
  
  @override
  List<Object> get props => [error];
}