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
                  child: Image(
                    image: AssetImage('assets/images/tela_inicial.png'),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 69.0,
            left: 135.0,
            child: TextButton(
              style: TextButton.styleFrom(
                  primary: ColorConstant.colorSecondaryFont,
                  textStyle: TextStyle(decoration: TextDecoration.underline)),
              child: Text('Não tenho cadastro'),
              onPressed: () {},
            ),
          ),
          Positioned(
              bottom: 146.0,
              left: 119.0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    clickLogin = !clickLogin;
                  });
                },
                child: SizedBox(
                  height: 175.0,
                  width: 175.0,
                  child: ClipPolygon(
                    sides: 6,
                    borderRadius: 5.0,
                    // Default 0.0 degrees
                    rotate: 90.0,
                    // Default 0.0 degrees
                    boxShadows: [
                      PolygonBoxShadow(color: Colors.black, elevation: 2.0),
                      PolygonBoxShadow(color: Colors.grey, elevation: 4.0)
                    ],
                    child: Container(
                        child: Center(
                          child: Text(clickLogin ? "Fazer login" : "Clicou",
                            style: TextStyle(color: Colors.white, fontSize: 17.0),
                          ),
                        ),
                        color: ColorConstant.colorMainOrange),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
