import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  //static const String routeName = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.colorMainOrange,
        title: Text("Alltech"),
        centerTitle: true,
      ),
      backgroundColor: ColorConstant.colorMainBackground,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Center(
            child: MaterialButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text("Sair"),
            ),
          )
        ],
      ),
    );
  }
}