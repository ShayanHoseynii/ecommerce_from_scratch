import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_state.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({super.key, this.iconColor, required this.onPressed});

  final Color? iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.shopping_bag, color: iconColor),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: TColors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return Text(
                      state.cartItems.length.toString(),
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: TColors.white,
                        fontSizeFactor: 0.8,
                      ),
                    );
                  } else {
                    return Text(
                      '0',
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: TColors.white,
                        fontSizeFactor: 0.8,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
