import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_state.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/validators/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ChangeNameScreen extends StatefulWidget {
  const ChangeNameScreen({super.key});

  @override
  State<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    // Pre-fill the text fields with the current user's name
    final userState = context.read<UserCubit>().state;
    if (userState is UserLoaded) {
      _firstNameController = TextEditingController(
        text: userState.user.firstName,
      );
      _lastNameController = TextEditingController(
        text: userState.user.lastName,
      );
    } else {
      _firstNameController = TextEditingController();
      _lastNameController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listenWhen:
          (previous, current) =>
              previous is UserLoading || previous is UserFailure,

      listener: (context, state) {
        if (state is UserLoaded) {
          Navigator.of(context).pop();
        } else if (state is UserFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        appBar: TAppBar(title: Text('Change Name'), showBackArrow: true),
        body: Padding(
          padding: EdgeInsetsGeometry.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  expands: false,
                  validator:
                      (value) =>
                          TValidator.validateEmptyText('First name', value),
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                  expands: false,
                  validator:
                      (value) =>
                          TValidator.validateEmptyText('Last name', value),
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print('object');
                      if (_formKey.currentState!.validate()) {
                        final dataToUpdate = {
                          'FirstName': _firstNameController.text.trim(),
                          'LastName': _lastNameController.text.trim(),
                        };
                        context.read<UserCubit>().updateUserData(dataToUpdate);
                      }
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
