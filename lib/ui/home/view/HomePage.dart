import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/weather_provider.dart';
import '../../../services/auth_service.dart';
import '../model/City.dart';
import '../widget/weather_data_output.dart';
import 'package:firebase_auth/firebase_auth.dart';



class HomePage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text('Weather App with AI Alerts'),
        actions: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(child: Text('Hi, ${user.displayName ?? 'User'}')),
            ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCityDropdown(weatherProvider),
                  ElevatedButton(
                    onPressed: weatherProvider.fetchWeather,
                    child: Text('VIEW WEATHER'),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 20),
            if (weatherProvider.isLoading)
              CircularProgressIndicator(),
            if (weatherProvider.error != null)
              Text(weatherProvider.error!, style: TextStyle(color: Colors.red)),
            if (weatherProvider.isWeatherDataLoaded && weatherProvider.weather != null)
              WeatherDataOutput(weather: weatherProvider.weather!),
          ],
        ),
      ),
    );
  }

  Widget _buildCityDropdown(WeatherProvider provider) {
    return DropdownButton<City>(
      value: provider.selectedCity,
      onChanged: (City? newCity) {
        if (newCity != null) {
          provider.selectCity(newCity);
        }
      },
      items: provider.cityList.map((City city) {
        return DropdownMenuItem<City>(
          value: city,
          child: Text(city.name),
        );
      }).toList(),
    );
  }
}
