import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:openweather/provider/weather_provider.dart';
import 'package:openweather/services/auth_service.dart';
import 'package:openweather/ui/home/view/HomePage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider()..loadCities(),
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final user = await _authService.signInWithGoogle();
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Failed')),
              );
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}



