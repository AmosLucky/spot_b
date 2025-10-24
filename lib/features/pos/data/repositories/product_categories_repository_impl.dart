import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/repositories/product_categories_repository.dart';
import '../datasources/local/product_categories_local_datasource.dart';
import '../datasources/remote/product_categories_remote_datasource.dart';
import '../models/product_category.dart';

class ProductCategoriesRepositoryImpl extends ProductCategoriesRepository {
  final ProductCategoriesLocalDatasource localDatasource;
  final ProductCategoriesRemoteDatasource remoteDatasource;
  final NetworkInfoRepository networkInfoRepository;

  ProductCategoriesRepositoryImpl(
    this.localDatasource,
    this.remoteDatasource,
    this.networkInfoRepository,
  );

  @override
  Stream<Result<List<ProductCategory>>> getProductCategories() async* {
    final isConnected = await networkInfoRepository.isConnected;

    final localResult = await localDatasource.getProductCategories();

    yield localResult;

    if (isConnected == true) {
      final allProductCategories = <ProductCategory>[];
      int currentPage = 1;
      int? lastPage;
      do {
        final remoteResult = await remoteDatasource.getProductCategories(pageNumber: currentPage);
        if (remoteResult is Success) {
          allProductCategories.addAll(remoteResult.data.data);
          currentPage = remoteResult.data.meta?.currentPage ?? currentPage;
          lastPage = remoteResult.data.meta?.lastPage ?? currentPage;
          currentPage++;
        }
        if (remoteResult is Failure) {
          yield Result.failure(remoteResult.error);
          break;
        }
      } while (lastPage != null && currentPage <= lastPage);
      localDatasource.saveProductCategories(allProductCategories);
      yield Result.success(allProductCategories);
    }
  }
}
