import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '/features/auth/data/models/login_response.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<LoginResponse, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return await authRepository.login(params.loginEntity);
  }
}

class LoginParams extends Equatable {
  final LoginEntity loginEntity;

  const LoginParams({required this.loginEntity});

  @override
  List<Object?> get props => [loginEntity];
}
