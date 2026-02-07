import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/premium_type_entity.dart';
import '../../domain/repositories/premium_type_repository.dart';
import '../state/premium_type_state.dart';

class PremiumTypeController extends StateNotifier<PremiumTypeState> {
  final PremiumTypeRepository repository;

  PremiumTypeController(this.repository) : super(const PremiumTypeState()) {
    _init();
  }

  void _init() {
    state = state.copyWith(isLoading: true);

    repository.watchPremiumTypes().listen((data) {
      state = state.copyWith(
        isLoading: false,
        all: data,
        filtered: _applyFilter(data, state.selectedFilterStatus, ''),
      );
    });
  }

  // ---------------- CRUD ----------------

  Future<void> addPremiumType({
    required String name,
    required double cost,
    required String status,
  }) {
    return repository.addPremiumType(
      PremiumTypeEntity(name: name, cost: cost, status: status),
    );
  }

  Future<void> updatePremiumType({
    required int id,
    required String name,
    required double cost,
    required String status,
  }) {
    return repository.updatePremiumType(
      PremiumTypeEntity(
        id: id,
        name: name,
        cost: cost,
        status: status,
      ),
    );
  }

  Future<void> deletePremiumType(int id) {
    return repository.deletePremiumType(id);
  }

  // ---------------- Filters ----------------

  void changeSearchStatus(String status) {
    state = state.copyWith(
      selectedFilterStatus: status,
      filtered: _applyFilter(state.all, status, ''),
    );
  }

  void filterByName(String query) {
    final filtered = state.all.where((e) {
      final matchesName =
          e.name.toLowerCase().contains(query.toLowerCase());

      final matchesStatus =
          state.selectedFilterStatus == 'All' ||
              e.status == state.selectedFilterStatus;

      return matchesName && matchesStatus;
    }).toList();

    state = state.copyWith(filtered: filtered);
  }

  List<PremiumTypeEntity> _applyFilter(
    List<PremiumTypeEntity> list,
    String status,
    String query,
  ) {
    return list.where((e) {
      final statusOk = status == 'All' || e.status == status;
      final nameOk =
          query.isEmpty || e.name.toLowerCase().contains(query.toLowerCase());
      return statusOk && nameOk;
    }).toList();
  }
}
