import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/screens/config/config_screen.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import '../../utils/helpers.dart';

class FirstLoginAlert extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  _FirstLoginAlertState createState() => _FirstLoginAlertState();
}

class _FirstLoginAlertState extends State<FirstLoginAlert> {
  final _email = TextEditingController();
  final GlobalKey<FormState> formKeyEsqueciSenha = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyEsqueciSenha,
      child: Consumer<UserManager>(
        builder: (context, userManager, __) {
          return AlertDialog(
            title: Text("Primeiro login!"),
            content: Container(
              height: 100.0,
              child: Text(
                  "Para alterar sua senha e sua foto, vá até a aba perfil"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  userManager.updateFirstLoginUser();
                  Navigator.of(context).pop();
                },
                child: Text("Confirmar", style: TextStyle(color: ColorConstant.colorMainOrange)),
              )
            ],
          );
        },
      ),
    );
  }
}
