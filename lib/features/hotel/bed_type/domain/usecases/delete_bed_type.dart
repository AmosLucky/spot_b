import '../repositories/bed_type_repository.dart';

class DeleteBedType {
  final BedTypeRepository repo;

  DeleteBedType(this.repo);

  Future<void> call(int id) {
    return repo.delete(id);
  }
}
