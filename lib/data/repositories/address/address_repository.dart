import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/features/models/address_model.dart';
import 'package:cwt_starter_template/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/firebase_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/format_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AddressRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthenticationRepository _authRepo = AuthenticationRepository.instance;

  Future<List<AddressModel>> getAddresses() async {
    try {
      final userId = _authRepo.currentUser?.uid;
      if (userId == null) throw Exception("User not logged in");

      final snapshot =
          await _db
              .collection('Users')
              .doc(userId)
              .collection("Addresses")
              .get();
      print(
        snapshot.docs.map((doc) => AddressModel.fromSnapshot(doc)).toList(),
      );
      return snapshot.docs
          .map((doc) => AddressModel.fromSnapshot(doc))
          .toList();
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

  Future<void> addAddress(AddressModel address) async {
    try {
      final userId = _authRepo.currentUser?.uid;
      if (userId == null) throw Exception("User not logged in");

      await _db
          .collection('Users')
          .doc(userId)
          .collection("Addresses")
          .add(address.toJson());
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

  Future<void> updateSelectedField(String addressId) async {
    try {
      final userId = _authRepo.currentUser?.uid;
      if (userId == null || userId.isEmpty) throw 'User not logged in';

      final batch = _db.batch();

      final querySnapshot =
          await _db
              .collection('Users')
              .doc(userId)
              .collection('Addresses')
              .where('selectedAddress', isEqualTo: true)
              .get();

      for (var doc in querySnapshot.docs) {
        batch.update(doc.reference, {'selectedAddress': false});
      }

      final selectedAddressRef = _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId);
      batch.update(selectedAddressRef, {'selectedAddress': true});

      await batch.commit();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong: $e';
    }
  }
}
