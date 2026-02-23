import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/credit_request_entity.dart';

class SelectedCreditIdsNotifier extends StateNotifier<Set<int>> {
  SelectedCreditIdsNotifier() : super({});

  void toggle(int id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }

  void toggleAll(List<CreditRequestEntity> credits) {
    final ids =
        credits.map((c) => c.id).whereType<int>().toSet();

    if (state.containsAll(ids)) {
      state = {};
    } else {
      state = ids;
    }
  }
}