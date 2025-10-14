import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '/core/error/failures.dart';

/// Abstract class for defining use cases
// ignore: avoid_types_as_parameter_names
abstract class UseCase<Type, Params> {
  /// Call method to execute the use case
  Future<Either<Failure, Type>> call(Params params);
}

/// Class for use cases that don't require parameters
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

