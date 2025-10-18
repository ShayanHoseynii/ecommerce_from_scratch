import 'package:cwt_starter_template/common/widgets/images/circular_image.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_state.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key, required this.dark, this.onTap});

  final bool dark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          final user = state.user;
          return ListTile(
            leading: CircularImage(
              dark: dark,
              image:
                  user.profilePicture.isNotEmpty
                      ? user.profilePicture
                      : TImages.user,
              isNetworkImage: user.profilePicture.isNotEmpty,
              width: 50,
              height: 50,
              padding: 0,
            ),
            title: Text(
              user.fullName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.apply(color: TColors.white),
            ),
            subtitle: Text(
              user.email,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.apply(color: TColors.white),
            ),
            trailing: IconButton(
              onPressed: onTap,
              icon: Icon(Iconsax.edit, color: TColors.white),
            ),
          );
        } else {
          return const _UserProfileShimmer();
        }
      },
    );
  }
}

class _UserProfileShimmer extends StatelessWidget {
  const _UserProfileShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[600]!,
      highlightColor: Colors.grey[400]!,
      child: ListTile(
        leading: const CircleAvatar(radius: 25, backgroundColor: Colors.white),
        title: Container(height: 20, width: 150, color: Colors.white),
        subtitle: Container(height: 14, width: 120, color: Colors.white),
      ),
    );
  }
}
