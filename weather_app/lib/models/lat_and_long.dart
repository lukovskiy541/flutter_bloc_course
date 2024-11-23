// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Citydata extends Equatable {
  final String name;
  final double lat;
  final double long;
  final String country;
  const Citydata({
    required this.name,
    required this.lat,
    required this.long,
    required this.country,
  });

  factory Citydata.fromJson(List<dynamic> data) {
    final citydata = Citydata(
      name: data[0]['name'] ?? '',
      lat: data[0]['lat']?.toDouble() ?? 0.0,
      long: data[0]['lon']?.toDouble() ?? 0.0,
      country: data[0]['country'] ?? '',
    );
    return citydata;
  }

  @override
  String toString() {
    return 'Citydata(name: $name, lat: $lat, long: $long, country: $country)';
  }

  @override
  List<Object> get props => [name, lat, long, country];
}
