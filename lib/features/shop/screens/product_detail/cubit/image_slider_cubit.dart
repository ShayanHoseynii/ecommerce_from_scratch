// image_slider_cubit.dart
import 'package:cwt_starter_template/features/authentication/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'image_slider_state.dart'; // Import the state file

class ImageSliderCubit extends Cubit<ImageSliderState> {
  ImageSliderCubit() : super(const ImageSliderState());

  // This method takes the product and initializes the state
  void loadProductImages(ProductModel product) {
    // Use Set to avoid duplicate images
    final Set<String> images = {};

    // 1. Add thumbnail
    images.add(product.thumbnail);

    // 2. Add all images from the Product Model
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // 3. Add all images from Product Variations
    if (product.productVariations != null) {
      images.addAll(product.productVariations!.map((variation) => variation.image));
    }
    // Emit the new state
    emit(ImageSliderState(
      selectedImageUrl: product.thumbnail, // Start with the thumbnail selected
      allProductImages: images.toList(),
    ));
  }

  // This method will be called when a user taps a thumbnail
  void selectImage(String imageUrl) {
    emit(state.copyWith(selectedImageUrl: imageUrl));
  }
}