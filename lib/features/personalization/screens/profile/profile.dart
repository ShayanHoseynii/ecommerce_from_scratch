import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/images/circular_image.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_state.dart';
import 'package:cwt_starter_template/features/authentication/screens/reauth/reauth.dart';
import 'package:cwt_starter_template/features/personalization/screens/profile/change_name.dart';
import 'package:cwt_starter_template/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:cwt_starter_template/utils/popups/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Profile')),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserReAuthenticationRequired) {
            TFullScreenLoader.stopLoading(context);
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ReauthLoginForm()));
          } else if (state is UserLoading) {
            TFullScreenLoader.openLoadingDialog(
              context,
              'Proccessing',
              TImages.docerAnimation,
            );
          } else if (state is UserFailure) {
            TFullScreenLoader.stopLoading(context);
            TLoaders.errorSnackBar(context: context, title: state.error);
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      /// Profile Picture
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            CircularImage(
                              dark: dark,
                              image:
                                  user.profilePicture.isNotEmpty
                                      ? user.profilePicture
                                      : TImages.user,
                              isNetworkImage:
                                  user.profilePicture.isNotEmpty ? true : false,
                              width: 80,
                              height: 80,
                            ),
                            TextButton(
                              onPressed:
                                  () =>
                                      context
                                          .read<UserCubit>()
                                          .uploadImageProfilePicture(),
                              child: const Text('Change Profile Picture'),
                            ),
                          ],
                        ),
                      ),

                      /// Details
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSectionHeading(
                        title: 'Profile Information',
                        showActionButton: false,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      TProfileMenu(
                        title: 'Name',
                        value: user.fullName,
                        onPressed:
                            () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ChangeNameScreen(),
                              ),
                            ),
                      ),
                      TProfileMenu(
                        title: 'Username',
                        value: user.username,
                        onPressed: () {},
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// Heading Personal Info
                      const TSectionHeading(
                        title: 'Personal Information',
                        showActionButton: false,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      TProfileMenu(
                        title: 'User ID',
                        value: user.id,
                        onPressed: () {},
                        icon: Iconsax.copy,
                      ),
                      TProfileMenu(
                        title: 'E-mail',
                        value: user.email,
                        onPressed: () {},
                      ),
                      TProfileMenu(
                        title: 'Phone Number',
                        value: user.phoneNumber,
                        onPressed: () {},
                      ),
                      TProfileMenu(
                        title: 'Gender',
                        value: 'Male',
                        onPressed: () {},
                      ),
                      TProfileMenu(
                        title: 'Date of Birth',
                        value: '10 Oct, 1994',
                        onPressed: () {},
                      ),
                      const Divider(),
                      Center(
                        child: TextButton(
                          onPressed:
                              () => showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title: const Text('Delete Account'),
                                    content: const Text(
                                      'Are you sure you want to delete your account? This action is not reversible and all of your data will be permanently removed.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () =>
                                                Navigator.of(
                                                  dialogContext,
                                                ).pop(),
                                        child: Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop();
                                          context
                                              .read<UserCubit>()
                                              .deleteUserAccount();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              ),
                          child: const Text(
                            'Close Account',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}
