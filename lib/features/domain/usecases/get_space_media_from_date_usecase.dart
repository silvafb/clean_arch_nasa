import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_arch/core/usecase/usecase.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUseCase implements UseCase<SpaceMediaEntity, DateTime> {

  final ISpaceMediaFromDateRepository _iSpaceMediaRepository;
  GetSpaceMediaFromDateUseCase(this._iSpaceMediaRepository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime? date) async {
    return date != null ? await _iSpaceMediaRepository.getSpaceMediaFromDate(date) : Left(NullParamFailure());
  }
}