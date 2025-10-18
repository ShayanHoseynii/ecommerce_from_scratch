import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String id;
  final String imageUrl;
  final String targetScreen;
  final bool isActive;
  BannerModel({
    required this.id,
    required this.imageUrl,
    required this.targetScreen,
    required this.isActive,
  });

  BannerModel copyWith({
    String? id,
    String? imageUrl,
    String? targetScreen,
    bool? isActive,
  }) {
    return BannerModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      targetScreen: targetScreen ?? this.targetScreen,
      isActive: isActive ?? this.isActive,
    );
  }
  static BannerModel empty() =>
      BannerModel(id: '', imageUrl: '', targetScreen: '', isActive: false);
  
  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'IsActive': isActive,
    };
  }

  factory BannerModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return BannerModel(
        id: document.id,
        imageUrl: data['ImageUrl'] ?? '',
        targetScreen: data['TargetScreen'] ?? '',
        isActive: data['IsActive'] ?? false,
      );
    } else {
      return BannerModel.empty();
    }
  }
}
