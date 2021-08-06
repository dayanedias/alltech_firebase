import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool clickLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorMainBackground,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 25.0),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 400.0,
                    height: 300.0,
                    child: Image(
                      image: AssetImage('assets/images/tela_de_login.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
