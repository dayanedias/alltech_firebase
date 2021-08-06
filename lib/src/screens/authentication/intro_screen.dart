import 'package:alltech_new_firebase/src/screens/authentication/login_screen.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'dart:async';

class IntroScreen extends StatefulWidget {
  static const String routeName = 'intro_screen';

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
                    width: double.infinity,
                    height: double.infinity,
                    image: AssetImage('assets/images/tela_inicial.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 313.0,
            left: 119.0,
            child: AnimatedOpacity(
              opacity: clickLogin ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: GestureDetector(
                onTap: () {
                  clickLogin
                      ? setState(() {
                    clickLogin = !clickLogin;
                  })
                      : null;
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
                    child: Container(
                        child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 42.0,
                                ),
                                Text(
                                  "ACS",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 58.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "INTERACTION",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                              ],
                            )),
                        color: ColorConstant.colorMainOrange),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 146.0,
            left: 119.0,
            child: AnimatedOpacity(
              opacity: clickLogin ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 800),
              child: GestureDetector(
                onTap: () {
                  clickLogin
                      ? null
                      : setState(() {
                    clickLogin = !clickLogin;
                    //Timer(Duration(seconds: 5), () => );
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
                          child: Text(
                            "Fazer login",
                            style: TextStyle(
                                color: Colors.white, fontSize: 17.0),
                          ),
                        ),
                        color: ColorConstant.colorMainOrange),
                  ),
                ),
              ),
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
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Solicitar novo usuário"),
                      content: Text(
                          "Favor entrar em contato com a empresa para pedir seu usuário e senha!"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Confirmar"))
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
