import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/profile/domain/entities/profile.dart';
import '/features/profile/domain/repositories/profile_repository.dart';

/// Use case for getting profile
class GetProfile implements UseCase<Profile, NoParams> {
  final ProfileRepository _repository;

  GetProfile(this._repository);

  @override
  Future<Either<Failure, Profile>> call(NoParams params) async {
    return await _repository.getProfile();
  }
}
