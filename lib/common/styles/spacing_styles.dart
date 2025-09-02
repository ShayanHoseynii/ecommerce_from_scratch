import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/rendering.dart';

class TSpacingStyles {
  static const EdgeInsetsGeometry paddingWithAppBarHeight =
      EdgeInsetsGeometry.only(
        left: TSizes.defaultSpace,
        right: TSizes.defaultSpace,
        top: TSizes.appBarHeight,
        bottom: TSizes.defaultSpace,
      );
}
