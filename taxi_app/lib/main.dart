import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'util/welcome.dart';
import 'main_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool seen = sharedPreferences.getBool('seen');
  Widget homeScreen = HomeScreen();
  if( seen == null || !seen){
      homeScreen = WelcomeScreen();
  }
  runApp(GoTaxi(homeScreen));
}

class GoTaxi extends StatelessWidget {
  final Widget homeScreen;
  GoTaxi(this.homeScreen);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: this.homeScreen,

    );
  }
}



