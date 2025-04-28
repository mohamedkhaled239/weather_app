import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio _dio;

  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = 'b354a44bf14b64c6c9cdad0af21ad4c0';

  WeatherService(this._dio);

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'q': cityName, 'appid': _apiKey, 'units': 'metric'},
      );

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Unexpected error, please try again.';
      log('DioException: $errorMessage');
      throw Exception(errorMessage);
    } catch (e, stackTrace) {
      log('General Error: $e', stackTrace: stackTrace);
      throw Exception('Unexpected error, please try again.');
    }
  }
}
