import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';

class SpaceMediaRepositoryImp extends ISpaceMediaFromDateRepository {

  final ISpaceMediaDatasource _datasource;
  SpaceMediaRepositoryImp(this._datasource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(DateTime date) async {
    try {
       final result = await _datasource.getSpaceMediaFromDate(date);
       return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}