import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(padding: 
        EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            
          ],
        ),),
      ),
    );
  }
}
