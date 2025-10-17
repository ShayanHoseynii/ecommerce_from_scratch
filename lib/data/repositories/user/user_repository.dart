import 'package:cwt_starter_template/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwt_starter_template/utils/exceptions/firebase_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/format_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserData(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

  Future<UserModel?> fetchUserRecord(String userId) async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(userId).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
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
Future<void> updateUserRecord(String userId, Map<String, dynamic> data) async {
    try {
      await _db.collection("Users").doc(userId).update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
  
  Future<void> removeUserRecord(String userId) async {
    try {
       await _db.collection("Users").doc(userId).delete();
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
