// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../domain/usecases/create_booking_usecase.dart';
// import '../../domain/usecases/get_bookings_usecase.dart';
// import '../controller/booking_controller.dart';
// import '../controller/booking_list_controller.dart';
// import '../state/booking_list_state.dart';
// import '../state/booking_state.dart';

// final bookingControllerProvider =
//     StateNotifierProvider<BookingController, BookingState>((ref) {
//   final repo = ref.read(bookingRepositoryProvider);
//   return BookingController(
//     CreateBookingUseCase(repo),
//     GetBookingsUseCase(repo),
//   );
// });


// final bookingListProvider =
//     StateNotifierProvider<BookingListController, BookingListState>((ref) {
//   final useCase = ref.read(getBookingsUseCaseProvider);
//   return BookingListController(useCase);
// });


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/database/database_client.dart';

import '../../data/datasources/local/booking_local_data_source.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../domain/usecases/create_booking_usecase.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../../domain/usecases/update_booking_use_case.dart';

import '../controller/booking_controller.dart';
import '../controller/booking_list_controller.dart';
import '../state/booking_state.dart';
import '../state/booking_list_state.dart';

/// Database
final bookingDatabaseProvider =
    Provider<DatabaseClient>((ref) => DatabaseClient());

/// Repository
final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final db = ref.read(bookingDatabaseProvider);
  return BookingRepositoryImpl(BookingLocalDataSource(db));
});

/// UseCases
final createBookingUseCaseProvider =
    Provider<CreateBookingUseCase>((ref) {
  return CreateBookingUseCase(ref.read(bookingRepositoryProvider));
});

final getBookingsUseCaseProvider =
    Provider<GetBookingsUseCase>((ref) {
  return GetBookingsUseCase(ref.read(bookingRepositoryProvider));
});

final updateBookingUseCaseProvider =
    Provider<UpdateBookingUseCase>((ref) {
  return UpdateBookingUseCase(ref.read(bookingRepositoryProvider));
});

/// Controllers
final bookingControllerProvider =
    StateNotifierProvider<BookingController, BookingState>((ref) {
  return BookingController(
    ref.read(createBookingUseCaseProvider),
    ref.read(getBookingsUseCaseProvider),
  );
});

final bookingListProvider =
    StateNotifierProvider<BookingListController, BookingListState>((ref) {
  return BookingListController(
    ref.read(getBookingsUseCaseProvider),
  );
});


