import 'package:weather_app/models/error.dart';
import 'package:weather_app/models/lat_and_long.dart';
import 'package:weather_app/models/weather_info.dart';
import 'package:weather_app/services/services.dart';
import '../exceptions/weather_exception.dart';

class WeatherRepository {
  const WeatherRepository({
    required this.weatherApiServices,
  });

  final Services weatherApiServices;

  Future<Weather> fetchWeather(String city) async {
    try {
      print('london fetchweather');
      final Citydata directGeocoding = await weatherApiServices.getCity(city);
      print('directGeocoding:');
      print('directGeocoding: $directGeocoding');

      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);

      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      print('weather: $weather');

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
