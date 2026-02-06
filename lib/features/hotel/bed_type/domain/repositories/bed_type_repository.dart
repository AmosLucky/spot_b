import '../entities/bed_type.dart';

abstract class BedTypeRepository {
  Future<void> add(String name);
  Future<List<BedType>> getAll();
  Future<void> update(int id, String name);
  Future<void> delete(int id);
}
