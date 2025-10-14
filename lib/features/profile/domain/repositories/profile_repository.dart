import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/features/profile/domain/entities/profile.dart';

/// Repository interface for profile functionality
abstract class ProfileRepository {
  /// Get list of profile
  Future<Either<Failure, Profile>> getProfile();
}
