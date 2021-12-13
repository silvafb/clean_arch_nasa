import 'package:dartz/dartz.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

abstract class ISpaceMediaFromDateRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(DateTime date);
}