import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/di/di.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/buttons/spotstock_secondary_button.dart';
import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../../features/register_management/presentation/widget/spotstock_register_widget.dart';
import '../../data/models/register.dart';
import '../../domain/usecases/get_pos_registers.dart';
import '../../domain/usecases/get_pos_registers_stream.dart';
import '../data_classes/register_filter_result.dart';
import '../widget/spotstock_filter_register_form.dart';
import 'spotstock_filter_register_form_view_model.dart';

class RegisterManagementViewModel extends SpotstockViewModel with SpotstockDialogMixin {
  final GetPOSRegisters getPOSRegisters;
  final GetPOSRegistersStream getPOSRegistersStream;
  RegisterManagementViewModel(this.getPOSRegisters, this.getPOSRegistersStream);

  List<Register>? _posRegisters;
  List<Register>? get posRegisters => _posRegisters;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  List<Register>? _filteredRegisters;
  List<Register>? get filteredRegisters => _filteredRegisters;

  Command0<void>? _getPOSRegistersStreamCommand;
  Command0<void> get getPOSRegistersStreamCommand => _getPOSRegistersStreamCommand ??= Command0<void>(_getPOSRegistersStream);

  bool get showDownloadButton => filteredRegisters != null;

  int get total => (isFiltering && getPOSRegistersStreamCommand.running) ? 0 : filteredRegisters?.length ?? 0;
  int get open =>
      (isFiltering && getPOSRegistersStreamCommand.running) ? 0 : filteredRegisters?.where((register) => register.isClosed == false).length ?? 0;
  int get closed =>
      (isFiltering && getPOSRegistersStreamCommand.running) ? 0 : filteredRegisters?.where((register) => register.isClosed == true).length ?? 0;

  RegisterFilterResult? _registerFilterResult;
  RegisterFilterResult? get registerFilterResult => _registerFilterResult;

  bool get isFiltering => registerFilterResult != null;

  @override
  void bind(BuildContext context) {
    _getPOSRegistersStreamCommand ??= Command0<void>(_getPOSRegistersStream)
      ..execute()
      ..addListener(() => notifyListeners());
  }

  Future<Result<void>> _getPOSRegistersStream() async {
    final stream = getPOSRegistersStream(
      startDate: registerFilterResult?.startDate,
      endDate: registerFilterResult?.endDate,
      updateLocalDatabase: !isFiltering,
    );
    await for (final result in stream) {
      result.when(
        onSuccess: (registers) {
          if (!isFiltering) {
            _posRegisters = registers;
          }
          _filteredRegisters = registers;
          notifyListeners();
        },
        onFailure: (error) {
          addError(error);
        },
      );
    }
    return Result.success(null);
  }

  Future<void> _onTapViewSummary(BuildContext context, Register register) async {
    SpotstockNavigation.goBack();
    SpotstockNavigation.goTo(
      '${SpotstockMobileRoutes.registerSummary}?${SpotstockRouteParams.registerId}=${register.id}',
    );
  }

  Future<void> onRegisterSelected(BuildContext context, Register register) async {
    await showSpotstockFormDialog(
      context,
      title: SpotstockStrings.registerActions,
      form: Column(
        children: [
          SpotstockRegisterWidget(
            register: register,
            onRegisterSelected: (register) {},
          )
        ],
      ),
      actions: [
        SpotstockPrimaryButton(
          child: Text(
            SpotstockStrings.viewSummary,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          onPressed: () {
            _onTapViewSummary(context, register);
          },
        ),
        SizedBox(height: SpotstockSizes.s8),
        SpotstockSecondaryButton(
          child: Text(SpotstockStrings.cancel),
          onPressed: () {
            SpotstockNavigation.goBack();
          },
        ),
      ],
    );
    return;
  }

  void onSearch(String value) {
    _filteredRegisters = _posRegisters?.where((register) {
      return register.user?.firstName?.toLowerCase().contains(value.toLowerCase()) ?? false;
    }).toList();
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
    _filteredRegisters = _posRegisters;
    notifyListeners();
  }

  Future<void> onTapFilter(BuildContext context) async {
    final viewModel = getIt<SpotstockFilterRegisterFormViewModel>()
      ..bind(
        context,
        startDate: registerFilterResult?.startDate,
        endDate: registerFilterResult?.endDate,
        status: registerFilterResult?.status,
      );
    final filterResult = await showSpotstockFormDialog<RegisterFilterResult>(
      context,
      title: SpotstockStrings.filterRegisters,
      form: SpotstockFilterRegisterForm(
        viewModel: viewModel,
      ),
      actions: [
        SpotstockPrimaryButton(
          child: Text(
            SpotstockStrings.apply,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          onPressed: () async {
            SpotstockNavigation.goBack(
              RegisterFilterResult(
                startDate: viewModel.startDate,
                endDate: viewModel.endDate,
                status: viewModel.status,
              ),
            );
            notifyListeners();
          },
        ),
        SizedBox(height: SpotstockSizes.s8),
        SpotstockSecondaryButton(
          child: Text(SpotstockStrings.clear),
          onPressed: () async {
            SpotstockNavigation.goBack(RegisterFilterResult());
            _registerFilterResult = null;
            notifyListeners();
          },
        ),
      ],
    );
    if (filterResult != null) {
      _registerFilterResult = filterResult;
      notifyListeners();
      await getPOSRegistersStreamCommand.execute();
    }
    return;
  }
}
