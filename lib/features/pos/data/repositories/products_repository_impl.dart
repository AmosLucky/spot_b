import 'dart:developer';

import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/local/products_local_datasource.dart';
import '../datasources/remote/products_remote_datasource.dart';
import '../models/product.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsLocalDatasource localDatasource;
  final ProductsRemoteDatasource remoteDatasource;
  final NetworkInfoRepository networkInfoRepository;

  ProductsRepositoryImpl(this.localDatasource, this.remoteDatasource, this.networkInfoRepository);

  @override
  Stream<Result<List<Product>>> getProducts({int? warehouseId}) async* {
    final isConnected = await networkInfoRepository.isConnected;

    final localResult = await localDatasource.getProducts(warehouseId: warehouseId);

    yield localResult;

    if (isConnected == true) {
      final allProducts = <Product>[];
      int currentPage = 1;
      int? lastPage;
      do {
        final remoteResult = await remoteDatasource.getProducts(
          pageNumber: currentPage,
          warehouseId: warehouseId,
        );
        if (remoteResult is Success) {
          allProducts.addAll(remoteResult.data.data);
          currentPage = remoteResult.data.meta?.currentPage ?? currentPage;
          lastPage = remoteResult.data.meta?.lastPage ?? currentPage;
          currentPage++;
        }
        if (remoteResult is Failure) {
          yield Result.failure(remoteResult.error);
          break;
        }
      } while (lastPage != null && currentPage <= lastPage);
      if (allProducts.isNotEmpty) {
        await localDatasource.saveProducts(allProducts, warehouseId: warehouseId);
      }
      yield Result.success(allProducts);
    }
  }
}
