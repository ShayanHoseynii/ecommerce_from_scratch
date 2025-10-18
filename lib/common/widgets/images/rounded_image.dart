import 'package:cached_network_image/cached_network_image.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.applyImageRadius = true, // Default to true, it's a rounded image widget
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.onPressed,
    this.borderRadius = 16,
  });

  final String imageUrl;
  final double? width, height;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit fit; // Removed nullable for clarity, it has a default
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    // ✅ Automatically detect if the image is a network URL
    final isNetworkImage = imageUrl.startsWith('http');

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              // ✅ Use Image.network for URLs
              ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: fit,
                // Show a shimmer effect while the image is loading for the first time
                placeholder: (context, url) =>  TShimmerEffect(
                  width: width ?? double.infinity,
                  height: height ?? 190,
                ),
                // Show an error icon if the download fails
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
              // ✅ Use Image.asset for local assets
              : Image.asset(
                  imageUrl,
                  fit: fit,
                ),
        ),
      ),
    );
  }
}