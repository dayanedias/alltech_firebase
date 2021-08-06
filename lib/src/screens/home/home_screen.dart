import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorMainBackground,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

      ),
      body: Stack(
        children: [
          Center(
            child: Text(
              "Home Screen",
              style: TextStyle(
                  color: ColorConstant.colorMainFont,
                  fontSize: 18.0
              ),
            ),
          )
        ],
      ),
    );
  }
}