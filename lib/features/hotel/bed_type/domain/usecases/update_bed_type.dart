import '../repositories/bed_type_repository.dart';

class UpdateBedType {
  final BedTypeRepository repository;

  UpdateBedType(this.repository);

  Future<void> call(int id, String name) async {
    await repository.update(id, name);
  }
}
