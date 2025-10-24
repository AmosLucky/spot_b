import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/repositories/attendants_repository.dart';
import '../datasources/local/attendants_local_datasource.dart';
import '../datasources/remote/attendants_remote_datasource.dart';
import '../models/attendant.dart';

class AttendantsRepositoryImpl extends AttendantsRepository {
  final AttendantsLocalDatasource localDatasource;
  final AttendantsRemoteDatasource remoteDatasource;
  final NetworkInfoRepository networkInfoRepository;

  AttendantsRepositoryImpl(this.localDatasource, this.remoteDatasource, this.networkInfoRepository);

  @override
  Stream<Result<List<Attendant>>> getAttendants() async* {
    final isConnected = await networkInfoRepository.isConnected;

    final localResult = await localDatasource.getAttendants();

    yield localResult;

    if (isConnected == true) {
      final allAttendants = <Attendant>[];
      int currentPage = 1;
      int? lastPage;
      do {
        final remoteResult = await remoteDatasource.getAttendants(pageNumber: currentPage);
        if (remoteResult is Success) {
          allAttendants.addAll(remoteResult.data.data);
          currentPage = remoteResult.data.meta?.currentPage ?? currentPage;
          lastPage = remoteResult.data.meta?.lastPage ?? currentPage;
          currentPage++;
        }
        if (remoteResult is Failure) {
          yield Result.failure(remoteResult.error);
          break;
        }
      } while (lastPage != null && currentPage <= lastPage);
      localDatasource.saveAttendants(allAttendants);
      yield Result.success(allAttendants);
    }
  }
}
