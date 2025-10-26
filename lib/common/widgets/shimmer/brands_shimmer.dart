import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class TBrandsShimmer extends StatelessWidget {
  const TBrandsShimmer({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(itemCount: itemCount, itemBuilder: (_, __) => TShimmerEffect(width: 300, height: 80));
  }
}
