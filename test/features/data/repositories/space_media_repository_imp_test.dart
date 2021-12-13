// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_imp.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main(){

  late SpaceMediaRepositoryImp repository;
  late ISpaceMediaDatasource datasource;

  setUp((){
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImp(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(description: 'teste', mediaType: 'teste media', title: 'title', mediaUrl: 'media url');
  final tDate = DateTime(2021, 02, 02);

  test('should return space media model when calls the datasource', () async {

    when(() => datasource.getSpaceMediaFromDate(tDate)).thenAnswer((_) async => tSpaceMediaModel);
    final result = await repository.getSpaceMediaFromDate(tDate);
    expect(result, Right(tSpaceMediaModel));
    
  });

  test('should return a server failure when calls the the call to datasource is unsucessful', () async {

    when(() => datasource.getSpaceMediaFromDate(tDate)).thenThrow(ServerException());
    final result = await repository.getSpaceMediaFromDate(tDate);
    expect(result, Left(ServerFailure()));

  });

}