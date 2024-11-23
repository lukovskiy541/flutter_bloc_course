import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/lat_and_long.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/models/weather_info.dart';
import 'package:weather_app/services/http_error_handler.dart';

class Services {
  const Services({
    required this.httpClient,
  });

  final http.Client httpClient;

  Future<Citydata> getCity(String name) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': name,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );
    try {
      print('pre response');
      final http.Response response = await httpClient.get(uri).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('Request timed out');
          throw TimeoutException('The connection has timed out');
        },
      );
      
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('got response');
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw ('Cannot get the location of $name');
      }

      final directGeocoding = Citydata.fromJson(responseBody);

      return directGeocoding;
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(Citydata city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${city.lat}',
        'lon': '${city.long}',
        'units': kUnit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);

      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
