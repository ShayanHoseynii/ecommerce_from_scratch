import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwt_starter_template/features/models/category_model.dart';
import 'package:cwt_starter_template/utils/formatters/formatter.dart';

class BrandModel {
  String id;
  String image;
  String name;
  int? productCount;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String> thumbnails; // Fetched from the products

  List<CategoryModel>? brandCategory;
  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.createdAt,
    this.updatedAt,
    this.productCount,
    this.brandCategory,
    this.thumbnails = const [],
  });
    BrandModel copyWith({List<String>? thumbnails}) {
    return BrandModel(
      id: id,
      name: name,
      image: image,
      thumbnails: thumbnails ?? this.thumbnails,
    );
  }

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedDate => TFormatter.formatDate(updatedAt);

  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  // Converting model into json to store in fireStore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'updatedAt': updatedAt = DateTime.now(),
      'createdAt': createdAt,
      'productCount': productCount = 0,
    };
  }

  // Converting the DocumentSnapShotData Received from firestore into Category model
  factory BrandModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return BrandModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        productCount: data['productCount'] ?? '',
        createdAt:
            data.containsKey('createdAt') ? data['createdAt']?.toDate() : null,
        updatedAt:
            data.containsKey('updatedAt') ? data['updatedAt']?.toDate() : null,
      );
    } else {
      return BrandModel.empty();
    }
  }
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();

    return BrandModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      productCount: int.tryParse((data['productCount'] ?? 0).toString()) ?? 0,
      createdAt:
          data.containsKey('createdAt') ? data['createdAt']?.toDate() : null,
      updatedAt:
          data.containsKey('updatedAt') ? data['updatedAt']?.toDate() : null,
    );
  }
}
