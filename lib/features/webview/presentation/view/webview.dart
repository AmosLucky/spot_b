import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/constants/colors/spotstock_colors.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/webview_view_model.dart';

class Webview extends StatefulWidget {
  final WebviewViewModel viewModel;
  const Webview({super.key, required this.viewModel});

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
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
          body: Column(
            children: [
              SpotstockAppbar(
                title: SpotstockStrings.spotstock,
                backgroundColor: SpotstockColors.c4D2B5B,
              ),
              Expanded(
                child: WebViewWidget(
                  controller: widget.viewModel.webviewController,
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
