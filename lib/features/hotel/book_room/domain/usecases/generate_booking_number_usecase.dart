class GenerateBookingNumberUseCase {
  int _counter = 1;

  String call() {
    return _counter.toString().padLeft(4, '0');
  }
}
