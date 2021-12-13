// ignore_for_file: prefer_const_declarations

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/utils/date_input_converter.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource_imp.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

import '../../../mocks/space_media_mock.dart';

class MockDateInputConverter extends Mock implements DateInputConverter {}

class MockClient extends Mock implements http.Client {}

void main() {
  late NasaDataSourceImp datasource;
  late DateInputConverter converter;
  late http.Client client;

  setUp(() {
    converter = MockDateInputConverter();
    client = MockClient();
    datasource = NasaDataSourceImp(
      converter: converter,
      client: client,
    );
    registerFallbackValue(DateTime(2000));
    registerFallbackValue(Uri());
  });

  final tDateTimeString = '2021-02-02';
  final tDateTime = DateTime(2021, 02, 02);

  // ignore: prefer_const_constructors
  final tSpaceMediaModel = SpaceMediaModel(
    description: 'teste',
    mediaType: 'teste',
    title: 'teste',
    mediaUrl: 'teste',
  );
  void successMock() {
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response(spaceMediaMock, 200));
  }

  test('should call DateInputConverter to convert the DateTime into a String',
      () async {
    // Arrange
    successMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => converter.format(tDateTime)).called(1);
  });

  test('should call the get method with correct url', () async {
    // Arrange
    successMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => client.get(Uri.https('api.nasa.gov', '/planetary/apod', {
          'api_key': 'DEMO_KEY',
          'date': '2021-02-02',
        }))).called(1);
  });
  test('should return a SpaceMediaModel when the call is successful', () async {
    // Arrange
    successMock();
    // Act
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(result, tSpaceMediaModel);
    verify(() => converter.format(tDateTime)).called(1);
  });
  test('should throw a ServerException when the call is unccessful', () async {
    // Arrange
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response('something went wrong', 400));
    // Act
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(() => result, throwsA(ServerException()));
    verify(() => converter.format(tDateTime)).called(1);
  });
}