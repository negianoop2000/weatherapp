import 'package:flutter/material.dart';
import 'package:openweather/ui/home/widget/sun_time.dart';
import 'package:openweather/ui/home/widget/temperature_section.dart';
import 'package:openweather/ui/home/widget/weather_property.dart';

import '../model/weather_data.dart';


class WeatherDataOutput extends StatelessWidget {
  final WeatherData weather;

  const WeatherDataOutput({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TemperatureSection(
            dateTime: weather.dateTime,
            temperature: weather.temperature,
            iconUrl: weather.weatherConditionIconUrl,
            description: weather.weatherConditionIconDescription,
            cityAndCountry: weather.cityAndCountry,
          ),
          SizedBox(height: 16),
          WeatherProperty(
            humidity: weather.humidity,
            pressure: weather.pressure,
            visibility: weather.visibility,
          ),
          Spacer(),
          SunTime(sunrise: weather.sunrise, sunset: weather.sunset),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
