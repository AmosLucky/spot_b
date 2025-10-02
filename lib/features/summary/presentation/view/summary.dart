import 'package:flutter/material.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/di/di.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/summary_view_model.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<SummaryViewModel>();
    return ListenableBuilder(
      listenable: viewModel..bind(context),
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Column(
              children: [
                SpotstockAppbar(
                  title: SpotstockStrings.salesSummary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
