import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/database_client.dart';
import '../../data/datasources/discount_local_data_source.dart';
import '../../data/repositories/discount_repository_impl.dart';
import '../../domain/repositories/discount_repository.dart';
import '../../domain/usecase/create_discount.dart';
import '../../domain/usecase/delete_discount.dart';
import '../../domain/usecase/get_discounts_by_booking.dart';
import '../../domain/usecase/update_discount.dart';

import '../controller/discount_controller.dart';
import '../state/discount_state.dart';

final appDatabaseProvider =
    Provider<DatabaseClient>((ref) => DatabaseClient());

final discountRepositoryProvider =
    Provider<DiscountRepository>((ref) {
  final db = ref.read(appDatabaseProvider);
  return DiscountRepositoryImpl(
    DiscountLocalDataSource(db),
  );
});

final createDiscountProvider = Provider((ref) =>
    CreateDiscount(ref.read(discountRepositoryProvider)));

final getDiscountsByBookingProvider = Provider((ref) =>
    GetDiscountsByBooking(ref.read(discountRepositoryProvider)));

final updateDiscountProvider = Provider((ref) =>
    UpdateDiscount(ref.read(discountRepositoryProvider)));

final deleteDiscountProvider = Provider((ref) =>
    DeleteDiscount(ref.read(discountRepositoryProvider)));

final discountControllerProvider =
    StateNotifierProvider<DiscountController, DiscountState>((ref) {
  return DiscountController(
    createDiscount: ref.read(createDiscountProvider),
    getDiscountsByBooking:
        ref.read(getDiscountsByBookingProvider),
    updateDiscount: ref.read(updateDiscountProvider),
    deleteDiscount: ref.read(deleteDiscountProvider),
  );
});
