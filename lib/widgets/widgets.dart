import 'package:flutter/material.dart';
import 'package:halo_app/models/weather_model.dart';
import 'package:halo_app/themes/themes.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:halo_app/services/theme_provider.dart';

// ========================[PERMISSION REQUEST DISPLAY]========================
class PermissionDeniedDisplay extends StatelessWidget {
  const PermissionDeniedDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on_rounded,
          color: Theme.of(context).colorScheme.onPrimary,
          size: MediaQuery.of(context).size.height * 0.08,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(
          'Enable location access to get accurate weather updates for your area.',
          textAlign: TextAlign.center,
          style: AppTypography.textStyle.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: MediaQuery.of(context).size.height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
   );
  }
}
// ========================[/PERMISSION REQUEST DISPLAY]========================

// ========================[LOADING WEATHER INDICATOR]========================
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2, 
          child: FractionallySizedBox(
            heightFactor: 0.5,
            child: AspectRatio(
              aspectRatio: 1,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
                strokeWidth: MediaQuery.of(context).size.height * 0.014,
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(
          'Loading weather...',
          textAlign: TextAlign.center,
          style: AppTypography.textStyle.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
      ],
    );
  }
}
// ========================[/LOADING WEATHER INDICATOR]========================

// ========================[NO CITY FOUND DISPLAY]========================
class NoCityFoundDisplay extends StatelessWidget {
  const NoCityFoundDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
     'Sorry, no location was found.\nCheck if location is active and restart the app',
     textAlign: TextAlign.center,
     style: AppTypography.textStyle.copyWith(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: MediaQuery.of(context).size.height * 0.036,
      fontWeight: FontWeight.bold,
    )
   );
  }
}
// ========================[/NO CITY FOUND DISPLAY]========================

// ========================[COLOR THEMES SWITCH]========================
class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => ThemeSwitchState();
}

class ThemeSwitchState extends State<ThemeSwitch> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.2,
        vertical:  MediaQuery.of(context).size.height * 0.06,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      
          Icon(
            Icons.light_mode,
            color: AppColors.sunIconColor,
            size: MediaQuery.of(context).size.height * 0.05,
          ),
          Transform.scale(
            scale: MediaQuery.of(context).size.height * 0.0018,
            child: Switch(
              thumbColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onPrimary),
              activeColor:  Theme.of(context).colorScheme.onPrimary,
              inactiveThumbColor:Theme.of(context).colorScheme.onPrimary,
             activeTrackColor: AppColors.moonIconColor,
              value: themeProvider.isDarkMode, 
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          Icon(
            Icons.dark_mode,
            color: AppColors.moonIconColor,
            size: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
    );
  }
}
// ========================[/COLOR THEMES SWITCH]========================

// ========================[LOCATION DISPLAY]========================
class LocationDisplay extends StatelessWidget {
  final Weather? currentWeather;
  const LocationDisplay({super.key, required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on_rounded,
          color: Theme.of(context).colorScheme.onPrimary,
          size: MediaQuery.of(context).size.height * 0.044,
        ),
        Text(
          currentWeather!.cityName,
          textAlign: TextAlign.center,
          style: AppTypography.textStyle.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: MediaQuery.of(context).size.height * 0.044,
          ),
        ),
      ],
   );
  }
}
// ========================[/LOCATION DISPLAY]========================

// ========================[CONDITION DISPLAY]========================
class ConditionDisplay extends StatelessWidget {
  final Weather? currentWeather;
  const ConditionDisplay({super.key, required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    return Text(
      currentWeather!.description.toUpperCase(),
      textAlign: TextAlign.center,
      style: AppTypography.textStyle.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: MediaQuery.of(context).size.height * 0.04,
      ),
   );
  }
}
// ========================[/CONDITION DISPLAY]========================

// ========================[PARAMETERS DISPLAY]========================
class ParametersDisplay extends StatelessWidget {
  final bool iconFirst;
  final IconData displayedIcon;
  final String displayedText;

  const ParametersDisplay({
    super.key,
    this.iconFirst = true, 
    required this.displayedIcon, 
    required this.displayedText
  });

  @override
  Widget build(BuildContext context) {
    final Icon icon = Icon(
      displayedIcon,
      color: Theme.of(context).colorScheme.onPrimary,
      size: MediaQuery.of(context).size.height * 0.036,
    );
    final Text text = Text(
      displayedText,
      textAlign: TextAlign.center,
      style: AppTypography.textStyle.copyWith(
         color: Theme.of(context).colorScheme.onPrimary,
        fontSize: MediaQuery.of(context).size.height * 0.036,
      ),
    );
    return Row(
      children: iconFirst ? [icon, text] : [text, icon],
    );
  }
}
// ========================[/PARAMETERS DISPLAY]========================

// ========================[WEATHER ANIMATION]========================
class AnimationDisplay extends StatefulWidget {
  final Weather? currentWeather;
  const AnimationDisplay({super.key, required this.currentWeather});

  @override
  State<AnimationDisplay> createState() => AnimationDisplayState();
}

class AnimationDisplayState extends State<AnimationDisplay> {
  String animation = 'clouds.json';

  _getAnimation() {
    switch (widget.currentWeather!.mainCondition) {
      case 'Clear':
        animation = 'clear.json';
        break;
      case 'Clouds':
        animation = 'clouds.json';
        break;
      case 'Drizzle':
        animation = 'rain.json';
        break;
      case 'Rain':
        animation = 'rain.json';
        break;
      case 'Snow':
        animation = 'snow.json';
        break;
      case 'Thunderstorm':
        animation = 'thunder.json';
        break;
      case 'Atmosphere':
        animation = 'drizzle.json';
        break;
    }
  }

   @override
  void initState() {
    super.initState();
    _getAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/animations/$animation');
  }
}
// ========================[/WEATHER ANIMATION]========================
