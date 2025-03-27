import 'package:flutter/material.dart';
import 'package:halo_app/services/weather_service.dart';
import 'package:halo_app/models/weather_model.dart';
import 'package:halo_app/widgets/widgets.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
 
  Weather? _currentWeather;
  bool _locationPermissionGranted = false;

  _fetchWeather() async {
    try {
      bool locationPermissionGranted = await WeatherService.getLocationPermission();
      setState(() => _locationPermissionGranted = locationPermissionGranted);
      if(locationPermissionGranted) {
        List<String?> locations = await WeatherService.getCurrentLocation();
        final  currentWeather = await WeatherService.getWeather(locations);
        setState(() => _currentWeather = currentWeather);
      } 
    } catch (e) {
      debugPrint('Error fetching weather: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Stack(
          children: [ 
            // Theme Switch
            ThemeSwitch(),
            Center(
              child: 
              // Check permissions
              (!_locationPermissionGranted) 
              ? PermissionDeniedDisplay()

                : // If permissions are granted, check if weather is loaded
                (_currentWeather == null)  
                ? LoadingIndicator()

                  : // Check If location is found.
                  (_currentWeather!.cityName == 'Unknown') 
                  ? NoCityFoundDisplay()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        // Location
                        LocationDisplay(currentWeather: _currentWeather),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        
                        // Animation
                        AnimationDisplay(currentWeather: _currentWeather),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),  

                        // Condition
                        ConditionDisplay(currentWeather: _currentWeather),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02), 

                        // Params  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ParametersDisplay(
                              displayedIcon: Icons.thermostat, 
                              displayedText: '${_currentWeather!.temperature}°C', 
                              iconFirst: true,
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.1),                       
                            ParametersDisplay(
                              displayedIcon: Icons.air, 
                              displayedText: '${_currentWeather!.windSpeed}m/s', 
                              iconFirst: false,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}