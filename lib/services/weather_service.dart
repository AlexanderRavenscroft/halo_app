import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:halo_app/models/weather_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  static final apiKey = dotenv.env['apiKey'];

  static Future<Weather> getWeather(List<String?> locations) async {
    for (final location in locations) {
      final response = await http.get(Uri.parse('$baseURL?q=$location&appid=$apiKey&units=metric'));

      if(response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else if(response.statusCode == 400) {
        debugPrint('Empty location, continuing');
        continue;
      } else if(response.statusCode == 404) {
        debugPrint('Cannot find location, continuing');
        continue;
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    }
    return Weather(cityName: 'Unknown', temperature: 0, windSpeed: 0, mainCondition: 'N/A', description: 'N/A');
  }

  /// Get Current User Location
  static Future <List<String?>> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings:  LocationSettings(accuracy: LocationAccuracy.best),
    );
    
    List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

    List<String?> locations =[
      placemarks[0].locality, 
      placemarks[0].subAdministrativeArea,
      placemarks[0].administrativeArea,
      placemarks[0].country,
    ];

    debugPrint(placemarks[0].toString());
    debugPrint(locations.toString());
    return locations;
  }

  /// Get Location permission
  static Future <bool> getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
          return false;
        }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}