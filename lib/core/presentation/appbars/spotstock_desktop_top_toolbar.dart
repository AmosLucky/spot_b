import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spotstock_inventory/core/constants/colors/spotstock_colors.dart';
import 'package:spotstock_inventory/core/constants/strings/spotstock_strings.dart';

import '../../../features/hotel/dashboard/presentation/providers/dashboard_provider.dart';
import '../../routing/router.dart';

class SpotstockDesktopTopToolbar extends ConsumerWidget {
  const SpotstockDesktopTopToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: SpotstockColors.c473069,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                context.go(SpotstockMobileRoutes.selectApp);
              },
              icon: Icon(
                Icons.arrow_back,
                color: SpotstockColors.cF2FCFE,
              )),
          // const SizedBox(width: 12),
          // ...['FRD', 'IN', 'RSV1', 'OUT', 'DTY', 'MTR', 'AVB2', 'INR']
          //     .map(_chip),
          const Spacer(),
          Text(
            SpotstockStrings.monthlyPlan,
            style: TextStyle(
              color: SpotstockColors.c473069,
            ),
          ),

          IconButton(
            onPressed: () {
               ref
                      .read(hotelDashboardControllerProvider.notifier)
                      .loadAllModule();
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Theme.of(context).colorScheme.onPrimary,
          //   ),
          //   onPressed: () {},
          //   child: const Text('POS'),
          // ),
          // const SizedBox(width: 8),
          // OutlinedButton(
          //   style: OutlinedButton.styleFrom(
          //     foregroundColor: Colors.white,
          //     side: const BorderSide(color: Colors.white),
          //   ),
          //   onPressed: () {},
          //   child: const Text('Clock In'),
          // ),
        ],
      ),
    );
  }
}
