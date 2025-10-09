import 'package:cwt_starter_template/utils/exceptions/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository {
  final _storage = GetStorage();
  final _auth = FirebaseAuth.instance;

  Future<bool> checkFirstTime() async {
    await GetStorage.init();

    // If 'IsFirstTime' does not exist, set it to true
    _storage.writeIfNull('IsFirstTime', true);

    // Read value
    final bool isFirstTime = _storage.read('IsFirstTime');

    // Remove splash
    FlutterNativeSplash.remove();

    // If first time, mark as false so next time user doesn’t see onboarding
    if (isFirstTime) {
      print(_storage);
      _storage.write('IsFirstTime', false);
    }

    return isFirstTime;
  }

  /// [Email Authentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
