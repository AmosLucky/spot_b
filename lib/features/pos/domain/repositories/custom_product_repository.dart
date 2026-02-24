import '../../../../core/shared/result.dart';

abstract class CustomProductRepository {
  Future<Result<int>> getCustomProductId();
  Future<Result<String>> getCustomProductCode();
}
