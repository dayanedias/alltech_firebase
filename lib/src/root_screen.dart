import 'package:alltech_new_firebase/src/resources/repository.dart';
import 'package:alltech_new_firebase/src/screens/authentication/intro_screen.dart';
import 'package:alltech_new_firebase/src/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  static const String routeName = 'root_screen';

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final Repository _repository = Repository();
  Stream<User> _currentUser;

  @override
  void initState() {
    _currentUser = _repository.onAuthStateChange;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: _currentUser,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        return snapshot.hasData ? HomeScreen() : IntroScreen();
      },
    );
  }
}
