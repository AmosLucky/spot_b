import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/bed_type.dart';
import '../../domain/usecases/add_bed_type.dart';
import '../../domain/usecases/get_bed_types.dart';
import '../../domain/usecases/update_bed_type.dart';
import '../../domain/usecases/delete_bed_type.dart';
import '../states/bed_types_state.dart';

class BedTypesController extends StateNotifier<BedTypesState> {
  final GetBedTypes getUseCase;
  final AddBedType addUseCase;
  final UpdateBedType updateUseCase;
  final DeleteBedType deleteUseCase;

  BedTypesController({
    required this.getUseCase,
    required this.addUseCase,
    required this.updateUseCase,
    required this.deleteUseCase,
  }) : super(BedTypesState.initial()) {
    loadBedTypes();
  }

  /// Original list to apply filters/search
  List<BedType> _allBedTypes = [];

  /// ---------------- Load ----------------
  Future<void> loadBedTypes() async {
    state = state.copyWith(isLoading: true);
    try {
      final list = await getUseCase.call();
      _allBedTypes = list;
      state = state.copyWith(bedTypes: list, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  /// ---------------- CRUD ----------------
Future<void> addBedType(String name) async {
  await addUseCase.call(name); // pass name only
  await loadBedTypes();
}


Future<void> updateBedType({
  required int id,
  required String name,
}) async {
  await updateUseCase.call(id, name); // pass separately
  await loadBedTypes();
}


  Future<void> deleteBedType(int id) async {
    await deleteUseCase.call(id);
    await loadBedTypes();
  }

  /// ---------------- Filters ----------------
  void changeFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
    _applyFilters();
  }

  void searchByName(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void _applyFilters() {
    List<BedType> filtered = _allBedTypes;

    // Filter by selectedFilter
    if (state.selectedFilter != 'All') {
      filtered = filtered
          .where((b) =>
              b.name.toLowerCase().contains(state.selectedFilter.toLowerCase()))
          .toList();
    }

    // Search filter
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered
          .where((b) =>
              b.name.toLowerCase().contains(state.searchQuery.toLowerCase()))
          .toList();
    }

    state = state.copyWith(bedTypes: filtered);
  }
}
