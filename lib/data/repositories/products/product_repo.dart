




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:cwt_starter_template/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/firebase_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/format_exceptions.dart';
import 'package:cwt_starter_template/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ProductRepository {

  final _db = FirebaseFirestore.instance;

  Future<void> uplaodDummy() async {
    try {
      
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

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection("Products").get();
      final list =
          snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
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

  Future<List<ProductModel>> fetchProductByQuery(Query query) async{
    try {
      final snapshot = await query.get();
      final list =
          snapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
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

  Future<List<ProductModel>> getProductsForCategory(String categoryId, {int limit = 4}) async {
    try {

      final snapshot = await _db.collection('Products')
                            .where('categoryIds', arrayContains: categoryId)
                            .limit(limit)
                            .get();
      
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } catch (e) {
      // Handle errors
      throw 'Something went wrong: $e';
    }
  }
Future<List<ProductModel>> getProductsByCategoryId(String categoryId) async {
    try {
      // Use 'array-contains' to query products where the categoryId exists in the categoryIds list
      final querySnapshot = await _db
          .collection('Products') // Make sure 'Products' matches your collection name
          .where('categoryIds', arrayContains: categoryId)
          .get();

      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw 'FirebaseException: ${e.message}';
    } on PlatformException catch (e) {
      throw 'PlatformException: ${e.message}';
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }


  Future<List<ProductModel>> getFeaturedProducts({int limit = 6}) async {
    try {
      final query = _db
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .limit(limit);
      return await fetchProductByQuery(query); // Use your existing method
    } catch (e) {
      // Handle or rethrow specific errors
      rethrow; 
    }
  }

  
  Future<List<ProductModel>> getProductsForBrand({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final querySnapshot =
          limit == -1
              ? await _db
                  .collection('Products')
                  .where('brand.id', isEqualTo: brandId)
                  .get()
              : await _db
                  .collection('Products')
                  .where('brand.id', isEqualTo: brandId)
                  .limit(limit)
                  .get();
      final products =
          querySnapshot.docs
              .map((doc) => ProductModel.fromSnapshot(doc))
              .toList();
      return products;
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


Future<List<ProductModel>> getProductsByIds(List<String> ids) async {
  try {
    // If the list of IDs is empty, return an empty list to avoid a Firebase error
    if (ids.isEmpty) return [];

    final snapshot = await _db
        .collection('Products')
        .where(FieldPath.documentId, whereIn: ids)
        .get();

    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  } on FirebaseException catch (e) {
    throw 'FirebaseException: ${e.message}';
  } on PlatformException catch (e) {
    throw 'PlatformException: ${e.message}';
  } catch (e) {
    throw 'Something went wrong. Please try again.';
  }
}

}