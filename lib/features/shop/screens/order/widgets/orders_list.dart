import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart'; 
import 'package:cwt_starter_template/features/shop/cubit/orders/cubit/order_cubit.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TOrdersListItems extends StatelessWidget {
  const TOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return ListView.separated(
            itemCount: 3, 
            shrinkWrap: true,
            separatorBuilder: (_, __) =>
                const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (_, __) => const _OrderListItemShimmer(),
          );
        }

        if (state is OrderFailure) {
          return Center(child: Text(state.error));
        }

        if (state is OrderLoaded) {
          if (state.orders.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          return ListView.separated(
            itemCount: state.orders.length, 
            shrinkWrap: true,
            separatorBuilder: (_, __) =>
                const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (_, index) {
              final order = state.orders[index];
              return TRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? TColors.dark : TColors.lightContainer,
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Iconsax.ship),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                order.status.name, 
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(
                                      color: TColors.primary,
                                      fontWeightDelta: 1,
                                    ),
                              ),
                              Text(
                                // Use dynamic date
                                DateFormat('dd MMM yyyy').format(order.orderDate),
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                          },
                          icon: const Icon(
                            Iconsax.arrow_right_34,
                            size: TSizes.iconSm,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// -- Row 2
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Iconsax.tag),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Order',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      order.id, // Use dynamic order ID
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Iconsax.calendar),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Shipping Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      order.deliveryDate != null
                                          ? DateFormat('dd MMM yyyy')
                                              .format(order.deliveryDate!)
                                          : 'N/A',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _OrderListItemShimmer extends StatelessWidget {
  const _OrderListItemShimmer();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.lightContainer,
      padding: const EdgeInsets.all(TSizes.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const TShimmerEffect(width: 24, height: 24, radius: 24), // Icon
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TShimmerEffect(width: 80, height: 15), // Status
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    const TShimmerEffect(width: 120, height: 12), // Date
                  ],
                ),
              ),
              const TShimmerEffect(width: 24, height: 24, radius: 24), // Icon
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const TShimmerEffect(width: 24, height: 24, radius: 24), // Icon
                    const SizedBox(width: TSizes.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TShimmerEffect(width: 40, height: 12), // Title
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                          const TShimmerEffect(width: 100, height: 12), // Value
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const TShimmerEffect(width: 24, height: 24, radius: 24), // Icon
                    const SizedBox(width: TSizes.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TShimmerEffect(width: 60, height: 12), // Title
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                          const TShimmerEffect(width: 100, height: 12), // Value
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}