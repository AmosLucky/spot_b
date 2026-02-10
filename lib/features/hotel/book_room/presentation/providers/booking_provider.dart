import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/database_client.dart';

import '../../../rooms/presentation/providers/room_providers.dart';
import '../../data/datasources/local/booking_local_data_source.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../domain/repositories/booking_repository.dart';

import '../../domain/usecases/create_booking_usecase.dart';

import '../../domain/usecases/get_available_rooms_use_case.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../../domain/usecases/update_booking_use_case.dart';
import '../controllers/booking_controller.dart';
import '../state/booking_state.dart';

final databaseProvider = Provider<DatabaseClient>((ref) {
  return DatabaseClient(); // ✅ new instance of the Drift DB
});

// ==================== DATABASE ====================
// You need to provide your database instance
// Example: final databaseProvider = Provider<DatabaseClient>((ref) => DatabaseClient());

// ==================== DATA SOURCE ====================
final bookingLocalDataSourceProvider = Provider<BookingLocalDataSource>((ref) {
  final database = ref.watch(databaseProvider);
  return BookingLocalDataSource(database);
});

// ==================== REPOSITORY ====================
final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final localDataSource = ref.watch(bookingLocalDataSourceProvider);
  return BookingRepositoryImpl(localDataSource);
});

// ==================== USE CASES ====================
final createBookingUseCaseProvider = Provider<CreateBookingUseCase>((ref) {
  final repository = ref.watch(bookingRepositoryProvider);
  return CreateBookingUseCase(repository);
});

final getBookingsUseCaseProvider = Provider<GetBookingsUseCase>((ref) {
  final repository = ref.watch(bookingRepositoryProvider);
  return GetBookingsUseCase(repository);
});

final updateBookingUseCaseProvider = Provider<UpdateBookingUseCase>((ref) {
  final repository = ref.watch(bookingRepositoryProvider);
  return UpdateBookingUseCase(repository);
});

final getAvailableRoomsUseCaseProvider =
    Provider<GetAvailableRoomsUseCase>((ref) {
  final repository = ref.watch(bookingRepositoryProvider);
  return GetAvailableRoomsUseCase(repository,ref.read(roomRepositoryProvider));
});

// ==================== CONTROLLER ====================
final bookingControllerProvider =
    StateNotifierProvider<BookingController, BookingState>((ref) {
  return BookingController(
    createBookingUseCase: ref.watch(createBookingUseCaseProvider),
    getBookingsUseCase: ref.watch(getBookingsUseCaseProvider),
    updateBookingUseCase: ref.watch(updateBookingUseCaseProvider),
    getAvailableRoomsUseCase: ref.watch(getAvailableRoomsUseCaseProvider),
    ref: ref
  );
});
