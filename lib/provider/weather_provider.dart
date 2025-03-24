
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../ui/home/model/City.dart';
import '../ui/home/model/weather_data.dart';
import '../ui/home/model/weather_response.dart';

class WeatherProvider with ChangeNotifier {
  List<City> _cityList = [];
  City? _selectedCity;
  WeatherData? _weather;
  bool _isWeatherDataLoaded = false;
  bool _isLoading = false;
  String? _error;

  final String apiKey = '53b408cc40aeecf391fca8c14c317304';

  List<City> get cityList => _cityList;
  City? get selectedCity => _selectedCity;
  WeatherData? get weather => _weather;
  bool get isWeatherDataLoaded => _isWeatherDataLoaded;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCities() async {
    try {
      final String response = await rootBundle.loadString('assets/city_list.json');
      final data = json.decode(response) as List<dynamic>;
      _cityList = data.map((city) => City.fromJson(city)).toList();
      _selectedCity = _cityList.isNotEmpty ? _cityList[0] : null;
      notifyListeners();
    } catch (e) {
      _error = "Failed to load city list: $e";
      notifyListeners();
    }
  }

  void selectCity(City city) {
    _selectedCity = city;
    _isWeatherDataLoaded = false;
    notifyListeners();
  }

  Future<void> fetchWeather() async {
    if (_selectedCity == null) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=${_selectedCity!.name}&APPID=$apiKey'),
      );

      if (response.statusCode == 200) {
        final weatherResponse = WeatherResponse.fromJson(jsonDecode(response.body));
        _weather = weatherResponse.toWeatherData();
        _isWeatherDataLoaded = true;
      } else {
        _error = 'Failed to load weather data';
      }
    } catch (e) {
      _error = "Error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}


