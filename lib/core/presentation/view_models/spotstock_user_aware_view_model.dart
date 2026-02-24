import 'package:flutter/material.dart';
import 'package:spotstock_inventory/features/auth/data/models/spotstock_user.dart';
import 'package:spotstock_inventory/features/auth/domain/usecases/get_spotstock_user.dart';
import 'spotstock_view_model.dart';

abstract class SpotstockUserAwareViewModel extends SpotstockViewModel {
  final GetSpotstockUser getSpotstockUser;

  /// Whether the user is an admin
  bool? get isAdmin {
    return _user?.isAdmin;
  }

  List<String>? get permissions {
    return _user?.permissions;
  }

  SpotstockUser? _user;
  SpotstockUser? get user => _user;

  SpotstockUserAwareViewModel(this.getSpotstockUser);

  @override
  void bind(BuildContext context) async {
    final userResult = await getSpotstockUser();
    userResult.when(
      onSuccess: (spotstockUser) {
        _user = spotstockUser;
        notifyListeners();
      },
      onFailure: (error) {
        addError(error);
      },
    );
  }

  bool userIsPermittedTo(String permission) {
    return permissions?.contains(permission) ?? false;
  }
}
