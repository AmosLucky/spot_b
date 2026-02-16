import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/add_booking_premium_service.dart';
import '../../domain/usecases/get_booking_premium_services.dart';
import '../../domain/usecases/delete_booking_premium_service.dart';
import '../state/booking_premium_service_state.dart';
import '../../domain/entities/booking_premium_service_entity.dart';

class BookingPremiumServiceController
    extends StateNotifier<BookingPremiumServiceState> {
  final AddBookingPremiumService addUseCase;
  final GetBookingPremiumServices getUseCase;
  final DeleteBookingPremiumService deleteUseCase;

  BookingPremiumServiceController({
    required this.addUseCase,
    required this.getUseCase,
    required this.deleteUseCase,
  }) : super(BookingPremiumServiceState());

  Future<void> load(int bookingId) async {
    state = state.copyWith(isLoading: true);
    final data = await getUseCase(bookingId);
    state = state.copyWith(isLoading: false, services: data);
  }

  Future<void> add(int bookingId) async {
    if (state.serviceId == null
        // state.startDate == null ||
        // state.endDate == null
        ) return;

    int days = state.endDate!.difference(state.startDate!).inDays;

    if (days <= 0) days = 1;

    final total = state.unitPrice * state.quantity;

    final entity = BookingPremiumServiceEntity(
      bookingId: bookingId,
      serviceId: state.serviceId!,
      quantity: state.quantity,
      unitPriceAtTime: state.unitPrice,
      startDate: DateTime.now(), //state.startDate!,
      endDate: DateTime.now(), // state.endDate!,
      numberOfDays: days,
      totalPrice: total,
    );

    await addUseCase(entity);

    await load(bookingId);
  }

  Future<void> delete(int id, int bookingId) async {
    await deleteUseCase(id);
    await load(bookingId);
  }

  // FORM SETTERS
  void setService(int id) => state = state.copyWith(serviceId: id);

  void setQuantity(int q) => state = state.copyWith(quantity: q);

  void setPrice(double p) => state = state.copyWith(unitPrice: p);

  void setStartDate(DateTime d) => state = state.copyWith(startDate: d);

  void setEndDate(DateTime d) => state = state.copyWith(endDate: d);
}
