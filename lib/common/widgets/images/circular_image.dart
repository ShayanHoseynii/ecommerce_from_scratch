import 'package:cached_network_image/cached_network_image.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    required this.dark,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    this.fit,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
  });
  final bool dark;
  final double width, height, padding;
  final BoxFit? fit;
  final bool isNetworkImage;
  final Color? overlayColor, backgroundColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (dark ? TColors.black : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child:
              isNetworkImage
                  ? CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.fill,
                    color: overlayColor,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            TShimmerEffect(width: 55, height: 55, radius: 50),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  )
                  : Image(
                    image: AssetImage(image),
                    fit: fit,
                    color: overlayColor,
                  ),
        ),
      ),
    );
  }
}
