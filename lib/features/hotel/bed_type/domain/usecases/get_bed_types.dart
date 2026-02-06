import '../entities/bed_type.dart';
import '../repositories/bed_type_repository.dart';

class GetBedTypes {
  final BedTypeRepository repo;

  GetBedTypes(this.repo);

  Future<List<BedType>> call() {
    return repo.getAll();
  }
}
