import 'package:alltech_new_firebase/src/manager/authentication_manager.dart';
import 'package:alltech_new_firebase/src/screens/authentication/landing_screen.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlltechApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context) => AuthenticationManager()),
      StreamProvider<User>.value(
          value: FirebaseAuth.instance.authStateChanges()
      )
    ],
      child: MaterialApp(
        title: "Alltech App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: ColorConstant.colorMainOrange,
        ),
        home: LandingScreen(),
      ),
    );
  }
}
