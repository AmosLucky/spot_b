import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../data_classes/register_filter_result.dart';

class SpotstockFilterRegisterFormViewModel extends SpotstockFormViewModel {
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  set startDate(DateTime? value) {
    _startDate = value;
    notifyListeners();
  }

  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  set endDate(DateTime? value) {
    _endDate = value;
    notifyListeners();
  }

  ResgisterStatus? _status;
  ResgisterStatus? get status => _status;
  set status(ResgisterStatus? value) {
    _status = value;
    notifyListeners();
  }

  @override
  void bind(
    BuildContext context, {
    DateTime? startDate,
    DateTime? endDate,
    ResgisterStatus? status,
  }) {
    _startDate = startDate;
    _endDate = endDate;
    _status = status;
    notifyListeners();
  }
}
