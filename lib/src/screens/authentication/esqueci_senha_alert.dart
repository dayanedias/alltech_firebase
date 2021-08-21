import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/screens/navigation/config_screen.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import '../../utils/helpers.dart';

class EsqueciSenhaAlert extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  _EsqueciSenhaAlertState createState() => _EsqueciSenhaAlertState();
}

class _EsqueciSenhaAlertState extends State<EsqueciSenhaAlert> {
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
            title: Text("Esqueci minha senha"),
            content: Container(
              height: 150.0,
              child: Column(
                children: [
                  Text(
                      "Digite seu e-mail para enviarmos uma nova senha"),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    enabled: !userManager.loading,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "E-mail...",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstant
                                  .colorMainOrange)),
                    ),
                    validator: (email) {
                      if (email.isEmpty)
                        return 'Campo obrigatório';
                      if (!Helpers.validateEmail(_email.text)) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.0,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text("${_errorMessage}", style: TextStyle(fontSize: 12.0, color: Colors.red),),
                    )
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancelar")),
              TextButton(
                  onPressed:  () {
                    if (formKeyEsqueciSenha.currentState
                        .validate()) {
                      userManager.resetPassword(
                          usuario: Usuario(
                              email: _email.text),
                          onFail: (e) {
                            setState(() {
                              _errorMessage = e;
                            });
                          },
                          onSuccess: () {
                            scaffoldKey.currentState
                                .showSnackBar(SnackBar(
                              content: Text("E-mail enviado com sucesso"),
                              backgroundColor: Colors.green,
                            ));
                          });
                    }
                  },
                  child: Text("Confirmar"))
            ],
          );
        },
      ),
    );
  }
}
