import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import '../../utils/helpers.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool clickLogin = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String _errorMessage = '';
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ColorConstant.colorMainBackground,
      resizeToAvoidBottomInset: false,
      body: Stack(
        key: UniqueKey(),
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
                      image: AssetImage('assets/images/tela_login.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: Consumer<UserManager>(
                  builder: (context, userManager, __){
                    return ListView(
                      padding: EdgeInsets.all(20.0),
                      shrinkWrap: true,
                      children: [
                        TextFormField(
                          controller: _email,
                          //onChanged: (value) { _email.text = value; },
                          keyboardType: TextInputType.emailAddress,
                          enabled: !userManager.loading,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "E-mail...",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                            ),
                            //errorText: _validate && _email.text.isEmpty ? 'Campo obrigatório' : _errorMessage == 'E-mail inválido' ? _errorMessage : null,
                          ),
                          validator: (email) {
                            if(email.isEmpty)
                              return 'Campo obrigatório';
                            if(!Helpers.validateEmail(_email.text)) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0,),
                        TextFormField(
                          controller: _password,
                          enabled: !userManager.loading,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Senha...",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                            ),
                            //errorText: _validate && _password.text.isEmpty ? 'Campo obrigatório' : _errorMessage == "E-mail e/ou senha não conferem" ? _errorMessage : null,
                          ),
                          validator: (password) {
                            if(password.isEmpty){
                              return 'Campo obrigatório';
                              return null;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8.0,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // TODO: Disparar a função de resetar senha;
                            },
                            child: Text("Esqueci minha senha", style: TextStyle(color: ColorConstant.colorMainOrange),),
                          ),
                        ),
                        SizedBox(height: 8.0,),
                        GestureDetector(
                            onTap: userManager.loading ? null : () {
                              if(formKey.currentState.validate()) {
                                userManager.signIn(
                                    usuario: Usuario(
                                        email: _email.text,
                                        password: _password.text
                                    ),
                                    onFail: (e) {
                                      scaffoldKey.currentState.showSnackBar(
                                          SnackBar(content: Text("${e}"),
                                            backgroundColor: Colors.red,
                                          )
                                      );
                                    },
                                    onSuccess: () {
                                      print("Sucesso!");
                                    }
                                );
                              }
                            },
                            child: SizedBox(
                              height: 50.0,
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                width: 267.0,
                                height: 40.0,
                                duration: Duration(milliseconds: 5000),
                                curve: Curves.fastOutSlowIn,
                                decoration: BoxDecoration(
                                    color: ColorConstant.colorMainOrange,
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                                ),
                                child: userManager.loading ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(ColorConstant.colorMainFont,),
                                ) : Text(
                                  "Entrar",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                        ),
                      ],
                    );
                  },
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
