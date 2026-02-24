import '../../../pos/data/models/create_sale_dto.dart';
import '../../data/models/grouped_hold.dart';
import '../../data/models/hold.dart';

class HoldSelectionResult {
  final CreateSaleDto? createSaleDto;
  final GroupedHold? groupedHold;
  final Hold? hold;

  HoldSelectionResult({
    this.createSaleDto,
    this.groupedHold,
    this.hold,
  });
}
