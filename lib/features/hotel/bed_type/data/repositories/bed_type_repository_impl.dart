import '../../../../../core/error_handling/app_error.dart';
import '../../domain/entities/bed_type.dart';
import '../../domain/repositories/bed_type_repository.dart';

import '../datasources/local/bed_type_local_service.dart';

class BedTypeRepositoryImpl implements BedTypeRepository {
  final BedTypeLocalService localService;

  BedTypeRepositoryImpl(this.localService);

  @override
  Future<void> add(String name) async {
    try {
      await localService.addBedType(name);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BedType>> getAll() async {
    try {
      return await localService.getBedTypes();
    } catch (e) {
      throw AppError(message: 'Repository error', originalError: e);
    }
  }

  @override
  Future<void> update(int id, String name) async {
    try {
      await localService.updateBedType(id, name);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await localService.deleteBedType(id);
    } catch (e) {
      rethrow;
    }
  }
}
