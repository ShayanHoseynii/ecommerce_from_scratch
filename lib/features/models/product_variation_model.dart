import 'package:equatable/equatable.dart';

class ProductVariationModel extends Equatable {
  final String id;
  final String sku;
  final String image;
  final String? description;
  final double price;
  final double salePrice;
  final int stock;
  final int soldQuantity;
  final Map<String, String> attributeValues;

  // Constructor with final fields
  const ProductVariationModel({
    required this.id,
    this.image = '',
    this.sku = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.soldQuantity = 0,
    required this.attributeValues,
  });

  /// Create empty instance
  static ProductVariationModel empty() => ProductVariationModel(
        id: '',
        attributeValues: {},
      );

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sku': sku,
      'image': image,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'soldQuantity': soldQuantity,
      'attributeValues': attributeValues,
    };
  }

  /// Create from JSON / Firestore snapshot data
  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationModel(
      id: json['id'] ?? '',
      sku: json['sku'] ?? '',
      image: (json['image'] ?? '').toString(),
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      salePrice: (json['salePrice'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      soldQuantity: json['soldQuantity'] ?? 0,
      attributeValues: json['attributeValues'] != null && json['attributeValues'] is Map
          ? Map<String, String>.from(json['attributeValues'])
          : {},
    );
  }
  
  /// copyWith Method to create a new instance with updated values
  ProductVariationModel copyWith({
    String? id,
    String? sku,
    String? image,
    String? description,
    double? price,
    double? salePrice,
    int? stock,
    int? soldQuantity,
    Map<String, String>? attributeValues,
  }) {
    return ProductVariationModel(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      stock: stock ?? this.stock,
      soldQuantity: soldQuantity ?? this.soldQuantity,
      attributeValues: attributeValues ?? this.attributeValues,
    );
  }
  

  // Equatable: Add all fields to the props list
  @override
  List<Object?> get props => [id, sku, image, description, price, salePrice, stock, soldQuantity, attributeValues];
}