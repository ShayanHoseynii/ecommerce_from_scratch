import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/features/models/order_model.dart';
import 'package:cwt_starter_template/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/firebase_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/format_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class OrderRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthenticationRepository _authRepo = AuthenticationRepository.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = _authRepo.currentUser!.uid;
      final snapshot =
          await _db.collection("Users").doc(userId).collection('Orders').get();
      final list =
          snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
      return list;
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

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
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
