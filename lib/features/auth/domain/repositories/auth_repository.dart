import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/login_response.dart';
import '../entities/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginEntity loginEntity);
}
