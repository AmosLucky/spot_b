class CalculateTotalAmountUseCase {
  double call({
    required Map<DateTime, List<String>> selectedRooms,
    required double pricePerRoom,
  }) {
    double total = 0;

    selectedRooms.forEach((_, rooms) {
      total += rooms.length * pricePerRoom;
    });

    return total;
  }
}
