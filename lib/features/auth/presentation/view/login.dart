import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/input_validation/spotstock_input_validation.dart';
import '../../../../core/presentation/logo/spotstock_logo.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/login_view_model.dart';

class Login extends StatefulWidget {
  final LoginViewModel viewModel;
  const Login({super.key, required this.viewModel});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SpotstockInputValidationMixin {
  @override
  void initState() {
    super.initState();
    widget.viewModel.bind(context);
    widget.viewModel.setupErrorListener(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Form(
                    key: widget.viewModel.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: SpotstockLogo(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: SpotstockSizes.s15),
                        Center(
                          child: Text(SpotstockStrings.pleaseLoginToContinue),
                        ),
                        const SizedBox(height: SpotstockSizes.s15),
                        SpotstockTextField(
                          hintText: SpotstockStrings.email,
                          controller: widget.viewModel.emailController,
                          validator: (value) => isValidEmail(value),
                        ),
                        const SizedBox(height: SpotstockSizes.s15),
                        SpotstockTextField(
                          obscureText: true,
                          hintText: SpotstockStrings.password,
                          controller: widget.viewModel.passwordController,
                          validator: (value) => isValidPassword(value),
                        ),
                        const SizedBox(height: SpotstockSizes.s15),
                        SpotstockPrimaryButton(
                          enabled: !widget.viewModel.loginCommand.running,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (widget.viewModel.formKey.currentState?.validate() == true) {
                              widget.viewModel.loginCommand.execute(context);
                            }
                          },
                          child: widget.viewModel.loginCommand.running
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: SpotstockSizes.s2,
                                )
                              : Text(
                                  SpotstockStrings.login,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SpotstockSizes.s16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
