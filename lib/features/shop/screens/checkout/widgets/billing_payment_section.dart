import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/shop/cubit/payment/payment_method_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/payment/payment_method_state.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/widgets/payemnt_bottom_sheet.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<PaymentMethodCubit>(),
                    child: const PaymentSelectionSheet(),
                  ),
              context: context,
            );
          },
        ),
        BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
          builder: (context, state) {
            return Row(
              children: [
                TRoundedContainer(
                  width: 60,
                  height: 35,
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.all(TSizes.sm),
                  child: Image(
                    image: AssetImage(state.selectedPaymentMethod.image),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Text(
                  state.selectedPaymentMethod.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
