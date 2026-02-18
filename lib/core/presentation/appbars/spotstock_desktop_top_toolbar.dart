import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotstock_inventory/core/constants/colors/spotstock_colors.dart';
import 'package:spotstock_inventory/core/constants/strings/spotstock_strings.dart';

import '../../routing/router.dart';

class SpotstockDesktopTopToolbar extends StatelessWidget {
  const SpotstockDesktopTopToolbar({super.key});

  // Widget _chip(String text) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 5),
  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.15),
  //       borderRadius: BorderRadius.circular(6),
  //     ),
  //     child: Text(text, style: const TextStyle(color: Colors.white)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
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
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.fullscreen, color: Colors.white),
          // ),
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
