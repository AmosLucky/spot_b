import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotstock_inventory/core/presentation/mesenger/app_messenger.dart';
import 'package:spotstock_inventory/features/hotel/booking/domain/entities/booking_entity.dart';
import 'package:spotstock_inventory/features/hotel/premium_type/domain/entities/premium_type_entity.dart';

import '../../domain/entities/booking_premium_service_entity.dart';
import '../model/premium_service_item.dart';
import '../state/booking_premium_service_form_state.dart';
import 'booking_premium_service_controller.dart';

class BookingPremiumServiceFormController
    extends StateNotifier<BookingPremiumServiceFormState> {
  BookingPremiumServiceFormController()
      : super(BookingPremiumServiceFormState());

  void selectRoom(String room) {
    state = state.copyWith(selectedRoom: room);
  }

  void addServiceRow() {
    final updated = [...state.items, PremiumServiceItem()];
    state = state.copyWith(items: updated);
  }

  void updateService(int index, PremiumTypeEntity service) {
    final updated = [...state.items];
    updated[index] = updated[index].copyWith(
      serviceId: service.id,
      serviceName: service.name,
      unitPrice: service.cost,
    );
    state = state.copyWith(items: updated);
  }

  void updateQuantity(int index, int quantity) {
    final updated = [...state.items];
    updated[index] = updated[index].copyWith(quantity: quantity);
    state = state.copyWith(items: updated);
  }

  Future<void> save(
    BookingEntity booking,
    BookingPremiumServiceController controller,
  ) async {
    for (var item in state.items) {
      final total = item.total;

     

      final entity = BookingPremiumServiceEntity(
        bookingId: booking.id!,
        serviceId: item.serviceId!,
        quantity: item.quantity,
        unitPriceAtTime: item.unitPrice,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        numberOfDays: 1,
        serviceName: item.serviceName,
        totalPrice: total,
      );

      await controller.addUseCase(entity);
      AppMessenger.showSuccess("Added Premuim service successfully");

      reset();
    }
  }

  void reset() {
    state = BookingPremiumServiceFormState.initial();
  }
}
