import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/core/network/network_info.dart';
import '/features/profile/data/datasources/profile_remote_datasource.dart';
import '/features/profile/domain/entities/profile.dart';
import '/features/profile/domain/repositories/profile_repository.dart';

/// Implementation of ProfileRepository
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  final NetworkInfo _networkInfo;

  ProfileRepositoryImpl({
    required ProfileRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    if (await _networkInfo.internetAvailable()) {
      try {
        final remoteProfile = await _remoteDataSource.getProfile();
        return Right(remoteProfile);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localProfile = await _remoteDataSource.getProfile();
        return Right(localProfile);
      } catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }
}
