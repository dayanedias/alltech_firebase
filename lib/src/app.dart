import 'package:alltech_new_firebase/src/root_screen.dart';
import 'package:alltech_new_firebase/src/screens/authentication/login_screen.dart';
import 'package:alltech_new_firebase/src/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class AlltechApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Alltech App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.deepOrange
      ),
      initialRoute: RootScreen.routeName,
      routes: {
        RootScreen.routeName: (context) => RootScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
