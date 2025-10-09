
import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/brands/brand_card.dart';
import 'package:cwt_starter_template/common/widgets/products/sortable/sortable_products.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Nike'),),
      body: SingleChildScrollView(
        child: Padding(padding: 
        const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            BrandCard(showBorder: true),
            const SizedBox(height: TSizes.spaceBtwSections,),

            TSortableProducts(),
          ],
        ),),
      ),
    );
  }
}