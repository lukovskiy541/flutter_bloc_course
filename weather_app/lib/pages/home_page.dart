import 'package:flutter/material.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/services.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    _checkConnectionAndFetchWeather();
  }
   Future<void> _checkConnectionAndFetchWeather() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print('No internet connection');
      return;
    }
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    print('myfetchweather');
    try {
      final weather = await WeatherRepository(
              weatherApiServices: Services(httpClient: http.Client()))
          .fetchWeather('London');
      print('Fetched weather: $weather');
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
