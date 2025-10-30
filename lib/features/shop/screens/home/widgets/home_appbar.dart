import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_state.dart';
import 'package:cwt_starter_template/features/shop/screens/cart/cart.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: TColors.grey),
          ),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return Text(
                  state.user.fullName,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.apply(color: TColors.white),
                );
              } else if (state is UserLoading) {
                return TShimmerEffect(width: 80, height: 15);
              } else {
                return Text(
                  'Welcome!',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.apply(color: TColors.white),
                );
              }
            },
          ),
        ],
      ),
      actions: [
        TCartCounterIcon(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen())),
          iconColor: TColors.white,
        ),
      ],
    );
  }
}
