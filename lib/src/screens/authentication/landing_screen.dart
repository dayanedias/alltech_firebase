import 'package:alltech_new_firebase/src/screens/authentication/intro_screen.dart';
import 'package:alltech_new_firebase/src/screens/authentication/login_screen.dart';
import 'package:alltech_new_firebase/src/screens/config/create_user_screen.dart';
import 'package:alltech_new_firebase/src/screens/home/connected_screen.dart';
import 'package:alltech_new_firebase/src/screens/home/home_screen.dart';
import 'package:alltech_new_firebase/src/screens/widgets/navigation_bar_widget.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Erro: ${snapshot.error}"),
              ),
            );
          }

          if(snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.active) {
                    User user = snapshot.data;
                    if(user == null) {
                      return LoginScreen();
                    } else {
                      return ConnectedScreen();
                    }
                  }
                  return Container();
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(
              color: ColorConstant.colorMainFont,
            ),
          );
        }
    );
  }
}
