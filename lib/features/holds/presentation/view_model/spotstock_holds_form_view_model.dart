import 'package:flutter/material.dart';
import 'package:spotstock_inventory/features/holds/data/mappers/hold_mapper.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/buttons/spotstock_secondary_button.dart';
import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../holds/domain/usecases/get_grouped_holds.dart';
import '../../../pos/data/models/create_sale_dto.dart';
import '../../data/models/grouped_hold.dart';
import '../data_classes/hold_selection_result.dart';
import '../widget/spotstock_grouped_holds_actions_form.dart';

class SpotstockHoldsFormViewModel extends SpotstockFormViewModel with SpotstockDialogMixin {
  final GetGroupedHolds getGroupedHolds;
  SpotstockHoldsFormViewModel(this.getGroupedHolds);

  late Command0<void> _getGroupedHoldsCommand;
  Command0<void> get getGroupedHoldsCommand => _getGroupedHoldsCommand;

  List<GroupedHold> _groupedHolds = [];
  List<GroupedHold> get groupedHolds => _groupedHolds;

  List<GroupedHold> _filteredGroupedHolds = [];
  List<GroupedHold> get filteredGroupedHolds => _filteredGroupedHolds;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  @override
  void bind(BuildContext context, [List<GroupedHold> groupedHolds = const []]) {
    _groupedHolds = groupedHolds;
    _filteredGroupedHolds = groupedHolds;
    notifyListeners();
    _getGroupedHoldsCommand = Command0<void>(_getGroupedHolds)..execute();
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      _filteredGroupedHolds = _groupedHolds;
      notifyListeners();
      return;
    }

    final searchValue = value.toLowerCase().trim();
    _filteredGroupedHolds = _groupedHolds.where((groupedHold) {
      final referenceNoMatch = groupedHold.groupedHoldReferenceNo?.toLowerCase().contains(searchValue) ?? false;
      final customerNameMatch = groupedHold.customerName?.toLowerCase().contains(searchValue) ?? false;
      final warehouseNameMatch = groupedHold.warehouseName?.toLowerCase().contains(searchValue) ?? false;

      return referenceNoMatch || customerNameMatch || warehouseNameMatch;
    }).toList();
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
    _filteredGroupedHolds = _groupedHolds;
    notifyListeners();
  }

  Future<Result<void>> _getGroupedHolds() async {
    final stream = getGroupedHolds();
    await for (final result in stream) {
      result.when(onSuccess: (groupedHolds) {
        _groupedHolds = groupedHolds;
        _filteredGroupedHolds = groupedHolds;
        notifyListeners();
      }, onFailure: (error) {
        addError(error);
      });
    }
    return Result.success(null);
  }

  Future<CreateSaleDto?> onGroupedHoldSelected(BuildContext context, GroupedHold groupedHold) async {
    SpotstockNavigation.goBack();
    return await showSpotstockFormDialog(
      context,
      title: SpotstockStrings.groupedHoldActions,
      form: SpotstockGroupedHoldActionsForm(
        groupedHold: groupedHold,
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
            final createSaleDto = CreateHoldDtoMapper.fromGroupedHold(groupedHold);
            SpotstockNavigation.goBack(createSaleDto);
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
      ],
    );
  }

  Future<HoldSelectionResult?> onViewAllHoldsPressed(BuildContext context) async {
    SpotstockNavigation.goBack();
    return await SpotstockNavigation.goTo<HoldSelectionResult?>(SpotstockMobileRoutes.holds);
  }
}
