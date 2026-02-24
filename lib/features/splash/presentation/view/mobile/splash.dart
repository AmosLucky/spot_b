// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../../core/presentation/logo/spotstock_logo.dart';
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
    widget.viewModel.bind(context);
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
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: SpotstockLogo(),
              ),
            ),
          ),
        );
      },
    );
  }
}
