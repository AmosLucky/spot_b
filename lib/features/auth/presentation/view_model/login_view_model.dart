import 'package:flutter/material.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/error_handling/app_error.dart';
import '../../../../core/networking/spotstock_api_error.dart';
import '../../../../core/networking/spotstock_status_code.dart';
import '../../../../core/presentation/snackbars/spotstock_snackbar.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/login_dto.dart';
import '../../data/models/login_response_dao.dart';
import '../../data/models/login_role_dao.dart';
import '../../data/models/login_user_dao.dart';
import '../../data/models/spotstock_user.dart';
import '../../domain/errors/errors.dart';
import '../../domain/usecases/get_spotstock_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/save_last_login_time.dart';
import '../../domain/usecases/save_spotstock_user.dart';
import '../../domain/usecases/save_token.dart';

class LoginViewModel extends SpotstockViewModel with SpotstockSnackbarMixin {
  final Login login;
  final SaveToken saveToken;
  final SaveSpotstockUser saveSpotstockUser;
  final SaveLastLoginTime saveLastLoginTime;
  final GetSpotstockUser getSpotstockUser;

  LoginViewModel(
    this.login,
    this.saveToken,
    this.saveSpotstockUser,
    this.saveLastLoginTime,
    this.getSpotstockUser,
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  late Command1<void, BuildContext> loginCommand;

  @override
  void bind(BuildContext context) async {
    loginCommand = Command1<void, BuildContext>(_login)
      ..addListener(() {
        notifyListeners();
      });
    final result = await getSpotstockUser();
    result.when(
      onSuccess: (spotstockUser) {
        if (spotstockUser?.email != null) {
          _emailController.text = spotstockUser!.email;
        }
      },
      onFailure: (error) {
        addError(error);
      },
    );
    notifyListeners();
  }

  void setupErrorListener(BuildContext context) {
    errorStream.listen((error) {
      if (context.mounted) {
        if (error is LoginError) {
          showErrorSnackbar(context, error, title: error.title, subtitle: error.subtitle);
          return;
        }
      }
    });
  }

  Future<Result<void>> _login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final result = await login(_createLoginDto());
    result.when(
      onSuccess: (response) {
        _validateResponse(response.data);
        saveToken(response.data.token!);
        saveSpotstockUser(_createSpotstockUser(response.data.user, response.data.role));
        saveLastLoginTime(DateTime.now());
        _formKey.currentState?.reset();
        _emailController.clear();
        _passwordController.clear();
        SpotstockNavigation.replace(SpotstockMobileRoutes.root, context);
      },
      onFailure: (error) {
        addError(
          LoginError(
            message: error.message,
            code: error.code,
            originalError: error.originalError,
            title: error.message,
            subtitle: error.message == SpotstockStrings.somethingWentWrong
                ? SpotstockStrings.pleaseCheckYourInternetConnectionAndTryAgain
                : SpotstockStrings.loginErrorSubtitle,
          ),
        );
      },
    );
    return result;
  }

  LoginDto _createLoginDto() {
    return LoginDto(
      email: _emailController.text,
      password: _passwordController.text,
      platform: 'mobile',
      languageCode: 'en',
    );
  }

  void _validateResponse(LoginResponseDao? response) {
    if (response == null) {
      addError(AppError(
        message: SpotstockStrings.invalidResponse,
        code: SpotstockStatusCode.internalAppError.toString(),
        originalError: null,
      ));
      return;
    }
    if (response.token == null) {
      addError(AppError(
        message: SpotstockStrings.tokenNotFound,
        code: SpotstockStatusCode.internalAppError.toString(),
        originalError: null,
      ));
      return;
    }
    if (response.user == null) {
      addError(AppError(
        message: SpotstockStrings.userNotFound,
        code: SpotstockStatusCode.internalAppError.toString(),
        originalError: null,
      ));
      return;
    }
    if (response.role == null) {
      addError(AppError(
        message: SpotstockStrings.roleNotFound,
        code: SpotstockStatusCode.internalAppError.toString(),
        originalError: null,
      ));
      return;
    }
  }

  SpotstockUser _createSpotstockUser(LoginUserDao? user, LoginRoleDao? role) {
    return SpotstockUser(
      id: user!.id!,
      firstName: user.firstName!,
      lastName: user.lastName!,
      email: user.email!,
      phone: user.phone!,
      roleId: role!.id!,
      roleName: role.name!,
      roleDisplayName: role.displayName!,
    );
  }

  @override
  void dispose() {
    loginCommand.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
