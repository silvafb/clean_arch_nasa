// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

void main(){

  final tSpaceMedia = SpaceMediaModel(description: 'teste', mediaType: 'teste', title: 'teste', mediaUrl: 'teste');

  test('should be a subclass of SpaceMediaEntity', (){

    expect(tSpaceMedia, isA<SpaceMediaEntity>());

  });

  test('should return a valid model', (){

    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);
    final result = SpaceMediaModel.fromJson(jsonMap);

    expect(result, tSpaceMedia);

  });

  test('should return a json mao containing the proper data', (){

    final expectedMap = {
      "explanation": "teste",
      "media_type": "teste",
      "title": "teste",
      "url": "teste"
    };
    final result = tSpaceMedia.toJson();

    expect(expectedMap, result);

  });

}