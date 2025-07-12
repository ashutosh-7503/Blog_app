import 'package:blog_app/core/error/failiures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failiure, SuccessType>> call(Params params);
}

class NoParams {}
