import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwt_starter_template/features/models/product_attribute_model.dart';
import 'package:cwt_starter_template/features/models/brand_model.dart';
import 'package:cwt_starter_template/features/models/product_variation_model.dart';
import 'package:cwt_starter_template/utils/constants/enums.dart';
import 'package:cwt_starter_template/utils/formatters/formatter.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? categoryId;
  String productType;
  String? description;

  List<String>? images;
  int soldQuantity;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;
  List<String>? categoryIds;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.soldQuantity = 0,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
    this.categoryIds,
  });

  /// Convert to Firestore-compatible map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'stock': stock,
      'sku': sku,
      'price': price,
      'salePrice': salePrice,
      'thumbnail': thumbnail,
      'productType': productType,
      'soldQuantity': soldQuantity,
      'date': date?.toIso8601String(),
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'description': description,
      'images': images ?? [],
      'brand': brand?.toJson(),
      'categoryIds': categoryIds ?? [],
      'productAttributes':
          productAttributes != null
              ? productAttributes!.map((e) => e.toJson()).toList()
              : [],
      'productVariations':
          productVariations != null
              ? productVariations!.map((e) => e.toJson()).toList()
              : [],
    };
  }

  /// Create from Firestore DocumentSnapshot
  factory ProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() == null) {
      return ProductModel.empty();
    }
    final data = document.data()!;

    return ProductModel(
      id: document.id,
      title: data['title'] ?? '',
      price: double.tryParse(data['price']?.toString() ?? '0.0') ?? 0.0,
      sku: data['sku'],
      stock: data['stock'] ?? 0,
      soldQuantity:
          data.containsKey('soldQuantity') ? data['soldQuantity'] ?? 0 : 0,
      isFeatured: data['isFeatured'] ?? false,
      salePrice: double.tryParse(data['salePrice']?.toString() ?? '0.0') ?? 0.0,
      thumbnail: data['thumbnail'] ?? '',
      categoryId: data['categoryId'] ?? '',
      description: data['description'] ?? '',
      productType: data['productType'] ?? '',

      brand: data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,

      categoryIds:
          data['categoryIds'] != null
              ? List<String>.from(data['categoryIds'])
              : [],

      images: data['images'] != null ? List<String>.from(data['images']) : [],

      productAttributes:
          data['productAttributes'] != null
              ? (data['productAttributes'] as List)
                  .map((e) => ProductAttributeModel.fromJson(e))
                  .toList()
              : [],

      productVariations:
          data['productVariations'] != null
              ? (data['productVariations'] as List)
                  .map((e) => ProductVariationModel.fromJson(e))
                  .toList()
              : [],

      date:
          data['date'] != null
              ? DateTime.tryParse(data['date'].toString())
              : null,
    );
  }

  /// Optional: Formats the date
  String get formattedDate => TFormatter.formatDate(date);

  /// Returns a placeholder empty model
  static ProductModel empty() => ProductModel(
    id: '',
    title: '',
    stock: 0,
    price: 0.0,
    thumbnail: '',
    productType: '',
  );

  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      for (var varitaion in product.productVariations!) {
        double priceToConsider =
            varitaion.salePrice > 0 ? varitaion.salePrice : varitaion.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      if (smallestPrice == largestPrice) {
        return smallestPrice.toString();
      } else {
        return '$smallestPrice - $largestPrice';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) {
    if (productType == ProductType.single.toString()) {
      return stock > 0 ? 'In Stock' : 'Out of Stock';
    } else {
      int totalStock = 0;
      for (var variation in productVariations!) {
        totalStock += variation.stock;
      }
      return totalStock > 0 ? 'In Stock' : 'Out of Stock';
    }
  }

  // Map Json-oriented document snapshot from Firebase to Model
factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
  final data = document.data() as Map<String, dynamic>;
  return ProductModel(
    id: document.id,
    sku: data['sku'] ?? '',
    title: data['title'] ?? '',
    stock: data['stock'] ?? 0,
    isFeatured: data['isFeatured'] ?? false,
    price: double.parse((data['price'] ?? 0.0).toString()),
    salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
    thumbnail: data['thumbnail'] ?? '',
    categoryId: data['categoryId'] ?? '',
    description: data['description'] ?? '',
    productType: data['productType'] ?? '',
    brand: BrandModel.fromJson(data['brand']),
    images: data['images'] != null ? List<String>.from(data['images']) : [],
    productAttributes: (data['productAttributes'] as List<dynamic>)
        .map((e) => ProductAttributeModel.fromJson(e))
        .toList(),
    productVariations: (data['productVariations'] as List<dynamic>)
        .map((e) => ProductVariationModel.fromJson(e))
        .toList(),
  );
}

double get effectivePrice {
  if (productType == ProductType.single.toString()) {
    // For single products, use its own price (or sale price if available)
    return salePrice > 0 ? salePrice : price;
  } else {
    // For variable products, find the minimum price among variations
    double minPrice = double.infinity;
    if (productVariations != null && productVariations!.isNotEmpty) {
      for (var variation in productVariations!) {
        final priceToConsider = variation.salePrice > 0 ? variation.salePrice : variation.price;
        if (priceToConsider < minPrice) {
          minPrice = priceToConsider;
        }
      }
      // Return the lowest found price, or 0 if no variations (shouldn't happen ideally)
      return minPrice == double.infinity ? 0.0 : minPrice;
    } else {
      // Fallback if somehow a variable product has no variations
      return 0.0;
    }
  }
}
}
