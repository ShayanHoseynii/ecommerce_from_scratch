import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwt_starter_template/features/models/category_model.dart';
import 'package:cwt_starter_template/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/firebase_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/format_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class CategoryRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final list =
          snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
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
  Future<List<CategoryModel>> getSubCategories(String parentId) async {
    try {
      final snapshot = await _db.collection("Categories").where('ParentId', isEqualTo: parentId).get();
      final list =
          snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
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
}
