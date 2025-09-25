// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../../core/assets/spotstock_assets.dart';
import '../../../../../core/constants/colors/spotstock_colors.dart';
import '../../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../../core/presentation/views/spotstock_view.dart';
import '../../view_model/splash_view_model.dart';

class Splash extends StatefulWidget {
  final SplashViewModel viewModel;
  const Splash({super.key, required this.viewModel});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await widget.viewModel.bind(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    SpotstockColors.cF2FCFE,
                    SpotstockColors.cFAF1FE,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Image.asset(
                  SpotstockAssets.logo,
                  width: SpotstockSizes.s250,
                  height: SpotstockSizes.s200,
                  color: SpotstockColors.c473069,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
