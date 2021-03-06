import 'package:alltech_new_firebase/src/app.dart';
import 'package:alltech_new_firebase/src/screens/authentication/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( AlltechApp(),);
}