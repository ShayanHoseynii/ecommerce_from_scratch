import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radious = 400,
    this.padding = 0,
    this.child,
    this.backgroundColor = TColors.white, this.margin,
  });

  final double? width;
  final double? height;
  final double radious;
  final double padding;
  final Widget? child;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(radious),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
