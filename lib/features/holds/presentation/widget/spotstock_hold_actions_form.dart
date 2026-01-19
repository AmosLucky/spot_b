import 'package:flutter/material.dart';

import '../../data/models/hold.dart';
import 'spotstock_hold_widget.dart';

class SpotstockHoldActionsForm extends StatelessWidget {
  final Hold hold;
  const SpotstockHoldActionsForm({super.key, required this.hold});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpotstockHoldWidget(
          hold: hold,
        ),
      ],
    );
  }
}
