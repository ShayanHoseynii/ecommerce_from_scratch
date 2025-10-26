import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:cwt_starter_template/features/models/product_variation_model.dart';
import 'package:equatable/equatable.dart';

class VariationState extends Equatable {
  final Map<String, String> selectedAttributes;
  final ProductVariationModel selectedVariation;
  final String selectedImageUrl;
  final List<String> allProductImages;

  const VariationState({
    required this.selectedAttributes,
    required this.selectedVariation,
    required this.selectedImageUrl,
    required this.allProductImages,
  });

  factory VariationState.initial(ProductModel product) {
    final images = <String>{};

    // 1. Add main thumbnail
    images.add(product.thumbnail);

    // 2. Add extra product images
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // 3. Add all unique, non-empty variation images
    if (product.productVariations != null) {
      images.addAll(
        product.productVariations!
            .map((variation) => variation.image)
            .where((image) => image.isNotEmpty), // <-- FIX 4: Filter out empty strings
      );
    }
    
    return VariationState(
      selectedAttributes: const {},
      selectedVariation: ProductVariationModel.empty(),
      selectedImageUrl: product.thumbnail, // <-- FIX 3: Set initial image
      allProductImages: images.toList(),
    );
  }

  VariationState copyWith({
    Map<String, String>? selectedAttributes,
    ProductVariationModel? selectedVariation,
    String? selectedImageUrl,
    List<String>? allProductImages,
  }) {
    return VariationState(
      selectedAttributes: selectedAttributes ?? this.selectedAttributes,
      selectedVariation: selectedVariation ?? this.selectedVariation,
      selectedImageUrl: selectedImageUrl ?? this.selectedImageUrl,
      allProductImages: allProductImages ?? this.allProductImages,
    );
  }

  @override
  List<Object> get props => [
        selectedAttributes,
        selectedVariation,
        selectedImageUrl,
        allProductImages,
      ];
}