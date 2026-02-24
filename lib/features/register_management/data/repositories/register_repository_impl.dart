import 'package:spotstock_inventory/core/error_handling/app_error.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/networking/spotstock_status_code.dart';
import '../../../../core/shared/result.dart';
import '../../../auth/data/models/spotstock_user.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/local/register_local_datasource.dart';
import '../datasources/remote/register_remote_datasource.dart';
import '../models/close_register_dto.dart';
import '../models/get_register_details_response_dao.dart';
import '../models/open_register_dto.dart';
import '../models/register.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterLocalDatasource registerLocalDatasource;
  final RegisterRemoteDatasource registerRemoteDatasource;
  final NetworkInfoRepository networkInfoRepository;

  RegisterRepositoryImpl(
    this.registerLocalDatasource,
    this.registerRemoteDatasource,
    this.networkInfoRepository,
  );

  @override
  Future<Result<void>> openRegister(OpenRegisterDto openRegisterDto) async {
    final isConnected = await networkInfoRepository.isConnected;
    if (isConnected == true) {
      final result = await registerRemoteDatasource.openRegister(openRegisterDto);
      if (result is Success) {
        await getPOSRegisters();
      }
      return result;
    } else {
      return await registerLocalDatasource.openRegister(openRegisterDto);
    }
  }

  @override
  Future<Result<void>> closeRegister(CloseRegisterDto closeRegisterDto) async {
    final isConnected = await networkInfoRepository.isConnected;
    if (isConnected == true) {
      final result = await registerRemoteDatasource.closeRegister(closeRegisterDto);
      if (result is Success) {
        await getPOSRegisters();
      }
      return result;
    } else {
      return await registerLocalDatasource.closeRegister(closeRegisterDto);
    }
  }

  @override
  Future<Result<bool>> isRegisterOpen() async {
    final isConnected = await networkInfoRepository.isConnected;
    if (isConnected == true) {
      final result = await registerRemoteDatasource.isRegisterOpen();
      if (result is Success) {
        await getPOSRegisters();
      }
      return result;
    } else {
      return await registerLocalDatasource.isRegisterOpen();
    }
  }

  @override
  Future<Result<List<Register>>> getPOSRegisters({
    DateTime? startDate,
    DateTime? endDate,
    bool updateLocalDatabase = true,
  }) async {
    final isConnected = await networkInfoRepository.isConnected;
    if (isConnected == true) {
      final allRegisters = <Register>[];
      int currentPage = 1;
      int? lastPage;
      do {
        final remoteResult = await registerRemoteDatasource.getPOSRegisters(
          pageNumber: currentPage,
          startDate: startDate,
          endDate: endDate,
        );
        if (remoteResult is Success) {
          allRegisters.addAll(remoteResult.data.data);
          currentPage = remoteResult.data.meta?.currentPage ?? currentPage;
          lastPage = remoteResult.data.meta?.lastPage ?? currentPage;
          currentPage++;
        }
        if (remoteResult is Failure) {
          return Result.failure(remoteResult.error);
        }
      } while (lastPage != null && currentPage <= lastPage);

      /// This hack is to add the current open register to the list because the API doesn't return it
      final registerDetailsResult = await registerRemoteDatasource.getRegisterDetails();
      if (registerDetailsResult is Success) {
        final isOpen = registerDetailsResult.data.data.isClosed == false;
        if (isOpen) {
          final register = Register(
            id: null,
            createdAt: registerDetailsResult.data.data.openedAt,
            closedAt: registerDetailsResult.data.data.closedAt,
            isClosed: registerDetailsResult.data.data.isClosed,
            openingCashAtHand: registerDetailsResult.data.data.cashInHand,
            closingCashAtHand: null,
            user: SpotstockUser(
              id: registerDetailsResult.data.data.staff?.id,
              firstName: registerDetailsResult.data.data.staff?.name,
              email: registerDetailsResult.data.data.staff?.email,
            ),
            note: null,
            isSynced: true,
          );
          allRegisters.add(register);
          allRegisters.sort((a, b) => (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
        }
      }

      if (updateLocalDatabase) {
        await registerLocalDatasource.saveRegisters(allRegisters);
      }
      return Result.success(allRegisters);
    } else {
      return await registerLocalDatasource.getPOSRegisters(
        startDate: startDate,
        endDate: endDate,
      );
    }
  }

  @override
  Stream<Result<List<Register>>> getPOSRegistersStream({
    DateTime? startDate,
    DateTime? endDate,
    bool updateLocalDatabase = true,
  }) async* {
    final isConnected = await networkInfoRepository.isConnected;

    final localResult = await registerLocalDatasource.getPOSRegisters(
      startDate: startDate,
      endDate: endDate,
    );

    yield localResult;

    if (isConnected == true) {
      final remoteResult = await getPOSRegisters(
        startDate: startDate,
        endDate: endDate,
      );

      yield remoteResult;
    }
  }

  @override
  Future<Result<GetRegisterDetailsResponseDao>> getRegisterDetails({int? registerId}) async {
    final isConnected = await networkInfoRepository.isConnected;
    if (isConnected == true) {
      final result = await registerRemoteDatasource.getRegisterDetails(registerId: registerId);
      if (result is Success) {
        await getPOSRegisters();
        return Result.success(result.data.data);
      }
      if (result is Failure) {
        return Result.failure(result.error);
      }
    } else {
      return await registerLocalDatasource.getRegisterDetails(registerId: registerId);
    }
    return Result.failure(
      AppError(
        message: SpotstockStrings.unableToGetRegisterDetails,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
      ),
    );
  }
}
