import 'package:dio/dio.dart';
import 'package:test_flutter/data/model/character_response.dart';
import 'package:test_flutter/data/servers/utils/constants.dart';

class CharactersService {
  late Dio _dio;

  CharactersService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    _dio = Dio(options);
  }

  Future<CharactersResponse> getAllCharacters() async {
    try {
      Response response = await _dio.get('/character');
      print('response: $response.data');
      return CharactersResponse.fromJson(response.data);
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }
}
