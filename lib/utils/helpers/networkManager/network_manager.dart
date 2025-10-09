import 'dart:async';
import 'package:cwt_starter_template/utils/helpers/networkManager/network_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';


class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  NetworkCubit({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity(),
        super(NetworkInitial()) {
    // Listen to connectivity changes
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    
    // Perform an initial check
    _initialize();
  }

  /// Performs an initial connectivity check when the Cubit is created.
  Future<void> _initialize() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  /// Updates the state based on the connectivity result.
  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      emit(NetworkDisconnected());
    } else {
      emit(NetworkConnected());
    }
  }

  /// A utility method for a one-time check of the internet connection status.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return !result.contains(ConnectivityResult.none);
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Cancel the connectivity subscription when the Cubit is closed.
  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}