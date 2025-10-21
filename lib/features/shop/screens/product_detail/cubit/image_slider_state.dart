import 'package:equatable/equatable.dart';

class ImageSliderState extends Equatable {
  final String selectedImageUrl;
  final List<String> allProductImages;

  const ImageSliderState({
    this.selectedImageUrl = '',
    this.allProductImages = const [],
  });

  ImageSliderState copyWith({
    String? selectedImageUrl,
    List<String>? allProductImages,
  }) {
    return ImageSliderState(
      selectedImageUrl: selectedImageUrl ?? this.selectedImageUrl,
      allProductImages: allProductImages ?? this.allProductImages,
    );
  }

  @override
  List<Object> get props => [selectedImageUrl, allProductImages];
}