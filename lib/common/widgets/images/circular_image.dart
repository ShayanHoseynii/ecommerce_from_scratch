import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({super.key, required this.dark,this.width = 56,this.height = 56,this.padding = TSizes.sm, this.fit, this.isNetworkImage = false, this.overlayColor, this.backgroundColor, required this.image});

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
        color: backgroundColor ??  (dark ? TColors.black : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image(
        image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider, 
        color:overlayColor,
      ),
    );
  }
}
