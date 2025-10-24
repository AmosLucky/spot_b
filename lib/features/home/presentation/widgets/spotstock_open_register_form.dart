import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../view_model/spotstock_open_register_form_view_model.dart';

class SpotstockOpenRegisterForm extends StatefulWidget {
  final SpotstockOpenRegisterFormViewModel viewModel;
  final VoidCallback onFormValidated;
  const SpotstockOpenRegisterForm({
    super.key,
    required this.onFormValidated,
    required this.viewModel,
  });

  @override
  State<SpotstockOpenRegisterForm> createState() => _SpotstockOpenRegisterFormState();
}

class _SpotstockOpenRegisterFormState extends State<SpotstockOpenRegisterForm> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.viewModel.requestFocusCommand.execute(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return Form(
          key: widget.viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(SpotstockStrings.cashAtHand),
                  const SizedBox(width: SpotstockSizes.s4),
                  NairaSymbol(
                    size: SpotstockSizes.s14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ],
              ),
              const SizedBox(height: SpotstockSizes.s8),
              SpotstockTextField(
                focusNode: widget.viewModel.cashAtHandFocusNode,
                hintText: SpotstockStrings.zero_00,
                keyboardType: TextInputType.number,
                controller: widget.viewModel.cashAtHandController,
                validator: (value) =>
                    value != null && value.isNotEmpty ? null : SpotstockStrings.cashAtHandRequired,
              ),
              const SizedBox(height: SpotstockSizes.s10),
              Text(SpotstockStrings.note),
              const SizedBox(height: SpotstockSizes.s8),
              SpotstockTextField(
                controller: widget.viewModel.noteController,
              ),
              const SizedBox(height: SpotstockSizes.s10),
            ],
          ),
        );
      },
    );
  }
}
