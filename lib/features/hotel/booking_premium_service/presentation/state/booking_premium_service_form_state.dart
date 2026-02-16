import '../model/premium_service_item.dart';

class BookingPremiumServiceFormState {
  final String? selectedRoom;
  final List<PremiumServiceItem> items;

  const BookingPremiumServiceFormState({
    this.selectedRoom,
    this.items = const [],
  });

  /// Initial empty state
  factory BookingPremiumServiceFormState.initial() {
    return const BookingPremiumServiceFormState(
      selectedRoom: null,
      items: [],
    );
  }

  double get overallTotal =>
      items.fold(0, (sum, item) => sum + item.total);

  BookingPremiumServiceFormState copyWith({
    String? selectedRoom,
    List<PremiumServiceItem>? items,
  }) {
    return BookingPremiumServiceFormState(
      selectedRoom: selectedRoom ?? this.selectedRoom,
      items: items ?? this.items,
    );
  }
}
