import '../repositories/bed_type_repository.dart';

class AddBedType {
  final BedTypeRepository repository;

  AddBedType(this.repository);

  Future<void> call(String name) async {
    await repository.add(name); // expects String
  }
}
