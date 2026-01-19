import 'package:flutter/material.dart';
import 'package:spotstock_inventory/features/holds/data/models/grouped_hold.dart';

import 'spotstock_grouped_hold_widget.dart';

class SpotstockGroupedHoldActionsForm extends StatelessWidget {
  final GroupedHold groupedHold;
  const SpotstockGroupedHoldActionsForm({super.key, required this.groupedHold});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpotstockGroupedHoldWidget(
          groupedHold: groupedHold,
        ),
      ],
    );
  }
}
