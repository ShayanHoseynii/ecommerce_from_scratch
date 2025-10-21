import 'package:cwt_starter_template/features/authentication/models/product_model.dart';
import 'package:cwt_starter_template/features/authentication/models/product_variation_model.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/cubit/variation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VariationCubit extends Cubit<VariationState> {
  VariationCubit(ProductModel product) : super(VariationState.initial(product));

  void onAttributeSelected(
    ProductModel product,
    String attributeName,
    String attributeValue,
  ) {
    final newSelectedAttributes = Map<String, String>.from(state.selectedAttributes);
    newSelectedAttributes[attributeName] = attributeValue;

    final selectedVariation =
        product.productVariations?.firstWhere(
              (variation) => _isSameAttributeValues(
                variation.attributeValues,
                newSelectedAttributes,
              ),
              orElse: () => ProductVariationModel.empty(),
            ) ??
            ProductVariationModel.empty();

    // The image to show is either the variation's image or the product's thumbnail
    final imageUrl = selectedVariation.image.isNotEmpty
        ? selectedVariation.image
        : product.thumbnail;

    emit(
      state.copyWith(
        selectedAttributes: newSelectedAttributes,
        selectedVariation: selectedVariation,
        selectedImageUrl: imageUrl,
      ),
    );
  }

  // FIX 1: ADD THIS METHOD
  /// Called when the user taps on a thumbnail in the image slider
  void onImageSelected(String imageUrl) {
    emit(state.copyWith(selectedImageUrl: imageUrl));
  }

  bool _isSameAttributeValues(
    Map<String, String> variationAttributes,
    Map<String, String> selectedAttributes,
  ) {
    if (variationAttributes.length != selectedAttributes.length) return false;
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  List<String> getAvailableAttributeValues(
    List<ProductVariationModel> varitaions,
    String attributeName,
    Map<String, String> selectedAttributes,
  ) {
    final availableValues = <String>{};
    for (var variation in varitaions) {
      bool isCompatible = true;
      selectedAttributes.forEach((key, value) {
        if (attributeName != key && variation.attributeValues[key] != value) {
          isCompatible = false;
        }
      });
      if (isCompatible && variation.attributeValues[attributeName] != null) {
        availableValues.add(variation.attributeValues[attributeName]!);
      }
    }
    return availableValues.toList();
  }
}