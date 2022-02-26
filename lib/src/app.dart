import 'package:alltech_new_firebase/src/manager/premio_manager.dart';
import 'package:alltech_new_firebase/src/manager/tipo_atividade_manager.dart';
import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/screens/authentication/landing_screen.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlltechApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserManager()),
      ChangeNotifierProvider(create: (context) => TipoAtividadeManager()),
      ChangeNotifierProvider(create: (context) => PremioManager()),
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
