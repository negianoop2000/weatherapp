import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:openweather/provider/weather_provider.dart';
import 'package:openweather/services/auth_service.dart';
import 'package:openweather/ui/home/model/City.dart';
import 'package:openweather/ui/home/model/weather_data.dart';
import 'package:openweather/ui/home/model/weather_response.dart';
import 'package:openweather/ui/home/view/HomePage.dart';
import 'package:openweather/ui/home/widget/weather_data_output.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockWeatherProvider extends Mock implements WeatherProvider {}
class MockAuthService extends Mock implements AuthService {}
class MockUser extends Mock implements User {}

void main() {
  late MockWeatherProvider mockWeatherProvider;
  late MockAuthService mockAuthService;
  late MockUser mockUser;

  setUp(() {
    mockWeatherProvider = MockWeatherProvider();
    mockAuthService = MockAuthService();
    mockUser = MockUser();
  });
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });



  Widget createTestWidget() {
    return MaterialApp(
      home: ChangeNotifierProvider<WeatherProvider>.value(
        value: mockWeatherProvider,
        child: HomePage(),
      ),
    );
  }

  testWidgets('Displays AppBar with title and user name', (WidgetTester tester) async {
    when(mockUser.displayName).thenReturn('Anoop');
    when(FirebaseAuth.instance.currentUser).thenReturn(mockUser);

    await tester.pumpWidget(createTestWidget());
    expect(find.text('Weather App with AI Alerts'), findsOneWidget);
    expect(find.text('Hi, Anoop'), findsOneWidget);
  });

  testWidgets('Logout confirmation dialog appears', (WidgetTester tester) async {
    when(mockUser.displayName).thenReturn('Anoop');
    when(FirebaseAuth.instance.currentUser).thenReturn(mockUser);
    when(mockAuthService.signOut()).thenAnswer((_) async {});

    await tester.pumpWidget(createTestWidget());
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    expect(find.text('Confirm Logout'), findsOneWidget);
    expect(find.text('Are you sure you want to log out?'), findsOneWidget);
  });

  testWidgets('City dropdown is displayed and selectable', (WidgetTester tester) async {
    final city1 = City(1,"","");
    final city2 = City(2,"","");

    when(mockWeatherProvider.cityList).thenReturn([city1, city2]);
    when(mockWeatherProvider.selectedCity).thenReturn(city1);

    await tester.pumpWidget(createTestWidget());

    expect(find.byType(DropdownButton<City>), findsOneWidget);
    await tester.tap(find.byType(DropdownButton<City>));
    await tester.pumpAndSettle();
    expect(find.text('Delhi'), findsWidgets);
    expect(find.text('Mumbai'), findsWidgets);
  });

  testWidgets('Displays loading indicator when fetching weather data', (WidgetTester tester) async {
    when(mockWeatherProvider.isLoading).thenReturn(true);
    when(mockWeatherProvider.isWeatherDataLoaded).thenReturn(false);
    when(mockWeatherProvider.error).thenReturn(null);

    await tester.pumpWidget(createTestWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays error message when weather fetch fails', (WidgetTester tester) async {
    when(mockWeatherProvider.isLoading).thenReturn(false);
    when(mockWeatherProvider.isWeatherDataLoaded).thenReturn(false);
    when(mockWeatherProvider.error).thenReturn('Failed to fetch weather data');

    await tester.pumpWidget(createTestWidget());
    expect(find.text('Failed to fetch weather data'), findsOneWidget);
  });

  testWidgets('Displays weather data when available', (WidgetTester tester) async {
    final mockWeather = WeatherData( dateTime: '', temperature: '', cityAndCountry: '', weatherConditionIconUrl: '', weatherConditionIconDescription: '', humidity: '', pressure: '', visibility: '', sunrise: '', sunset: '');
    when(mockWeatherProvider.weather).thenReturn(mockWeather);

    await tester.pumpWidget(createTestWidget());
    expect(find.byType(WeatherDataOutput), findsOneWidget);
    expect(find.text('Delhi'), findsOneWidget);
  });
}
