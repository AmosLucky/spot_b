import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
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
                // trailing: SpotstockIconButton(
                //   tooltip: SpotstockStrings.logout,
                //   icon: Icon(Icons.logout, color: Colors.white, size: SpotstockSizes.s20),
                //   onPressed: () {
                //     widget.viewModel.logoutCommand.execute(context);
                //   },
                // ),
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
