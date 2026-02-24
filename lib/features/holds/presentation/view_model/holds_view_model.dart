import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/banners/spotstock_dialog_warning_banner.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/buttons/spotstock_secondary_button.dart';
import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/snackbars/spotstock_snackbar.dart';
import '../../../../core/presentation/snackbars/spotstock_snackbar_type.dart';
import '../../../../core/presentation/view_models/spotstock_user_aware_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../../features/auth/domain/usecases/get_spotstock_user.dart';
import '../../data/mappers/hold_mapper.dart';
import '../../data/models/hold.dart';
import '../../domain/usecases/delete_hold.dart';
import '../../domain/usecases/get_holds.dart';
import '../data_classes/hold_selection_result.dart';
import '../widget/spotstock_hold_actions_form.dart';

class HoldsViewModel extends SpotstockUserAwareViewModel with SpotstockDialogMixin, SpotstockSnackbarMixin {
  final GetHolds getHolds;
  final DeleteHold deleteHold;

  HoldsViewModel(
    this.getHolds,
    this.deleteHold,
    GetSpotstockUser getSpotstockUser,
  ) : super(getSpotstockUser);

  List<Hold> _holds = [];
  List<Hold> get holds => _holds;

  List<Hold> _filteredHolds = [];
  List<Hold> get filteredHolds => _filteredHolds;

  int get holdCount => _holds.length;

  bool get isHoldsCountMoreThanOne => holdCount > 1;

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  late Command0<void> _getHoldsCommand;
  Command0<void> get getHoldsCommand => _getHoldsCommand;

  Command1<void, Hold>? _deleteHoldCommand;
  Command1<void, Hold>? get deleteHoldCommand => _deleteHoldCommand;

  @override
  void bind(BuildContext context) async {
    super.bind(context);
    _getHoldsCommand = Command0<void>(_getHolds)..execute();
    _deleteHoldCommand ??= Command1<void, Hold>(_deleteHold)..addListener(() => notifyListeners());
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      _filteredHolds = _holds;
      notifyListeners();
      return;
    }

    final searchValue = value.toLowerCase().trim();
    _filteredHolds = _holds.where((hold) {
      final referenceCodeMatch = hold.referenceCode?.toLowerCase().contains(searchValue) ?? false;
      final customerNameMatch = hold.customerName?.toLowerCase().contains(searchValue) ?? false;
      final warehouseNameMatch = hold.warehouseName?.toLowerCase().contains(searchValue) ?? false;

      return referenceCodeMatch || customerNameMatch || warehouseNameMatch;
    }).toList();
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
    _filteredHolds = _holds;
    notifyListeners();
  }

  Future<Result<void>> _getHolds() async {
    final stream = getHolds();
    await for (final result in stream) {
      result.when(
        onSuccess: (holds) {
          _holds = holds;
          _filteredHolds = holds;
          notifyListeners();
        },
        onFailure: (error) {
          addError(error);
        },
      );
    }
    return Result.success(null);
  }

  Future<Result<void>> _deleteHold(Hold hold) async {
    final result = await deleteHold(hold);
    result.when(onSuccess: (_) async {
      showSpotstockSnackbar(
        type: SpotstockSnackbarType.success,
        title: SpotstockStrings.success,
        message: SpotstockStrings.holdVoidedSuccessfully,
      );
      await getHoldsCommand.execute();
    }, onFailure: (error) {
      notifyListeners();
      addError(error);
    });
    return result;
  }

  Future<void> onVoidPressed(BuildContext context, Hold hold) async {
    await showSpotstockInformationDialog(
      context,
      title: SpotstockStrings.areYouSure,
      icon: Icon(Icons.warning),
      description: SpotstockStrings.thisActionCannotBeUndone,
      banner: SpotstockDialogWarningBanner(
        message: SpotstockStrings.deleteHoldWarning,
      ),
      actions: [
        SpotstockPrimaryButton(
          color: Theme.of(context).colorScheme.error,
          onPressed: () async {
            SpotstockNavigation.goBack();
            await deleteHoldCommand?.execute(hold);
          },
          child: Text(
            SpotstockStrings.yesVoid,
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
        ),
        SizedBox(height: SpotstockSizes.s16),
        SpotstockSecondaryButton(
          child: Text(SpotstockStrings.noCancel),
          onPressed: () {
            SpotstockNavigation.goBack();
          },
        ),
      ],
    );
    return;
  }

  Future<HoldSelectionResult?> onHoldSelected(BuildContext context, Hold hold) async {
    final holdSelectionResult = await showSpotstockFormDialog<HoldSelectionResult?>(
      context,
      title: SpotstockStrings.holdActions,
      form: SpotstockHoldActionsForm(
        hold: hold,
      ),
      actions: [
        SpotstockPrimaryButton(
          child: Text(
            SpotstockStrings.load,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          onPressed: () {
            final createSaleDto = CreateHoldDtoMapper.toCreateSaleDto(hold);
            final holdSelectionResult = HoldSelectionResult(
              createSaleDto: createSaleDto,
              hold: hold,
            );
            SpotstockNavigation.goBack(holdSelectionResult);
          },
        ),
        SizedBox(height: SpotstockSizes.s8),
        SpotstockSecondaryButton(
          child: Text(
            SpotstockStrings.print,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          onPressed: () {
            // SpotstockNavigation.goBack();
          },
        ),
        isAdmin == true ? SizedBox(height: SpotstockSizes.s8) : SizedBox.shrink(),
        isAdmin == true
            ? SpotstockPrimaryButton(
                color: Theme.of(context).colorScheme.error,
                onPressed: () async {
                  SpotstockNavigation.goBack();
                  await onVoidPressed(context, hold);
                },
                child: Text(
                  SpotstockStrings.voidHold,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
    if (holdSelectionResult != null) {
      SpotstockNavigation.goBack(holdSelectionResult);
      return holdSelectionResult;
    }
    return holdSelectionResult;
  }
}
