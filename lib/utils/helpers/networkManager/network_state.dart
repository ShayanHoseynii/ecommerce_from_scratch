import 'package:equatable/equatable.dart';

/// Base class for network states.
abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

/// The initial state before any connection check has been made.
class NetworkInitial extends NetworkState {}

/// The state representing a successful internet connection.
class NetworkConnected extends NetworkState {}

/// The state representing a lost internet connection.
class NetworkDisconnected extends NetworkState {}