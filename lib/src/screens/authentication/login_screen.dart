import 'package:alltech_new_firebase/src/manager/authentication_manager.dart';
import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import '../../utils/validator.dart';

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
  String _errorMessage = '';
  bool _validate = false;

  Future<void> _loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text
      );
    } on FirebaseAuthException catch (e) {
      print("ERROR ${e.code}");
      if (e.code == 'invalid-email') {
        setState(() {
          _errorMessage = "E-mail inválido";
        });
      } else if (e.code == 'user-not-found') {
        setState(() {
          _errorMessage = "E-mail e/ou senha não conferem";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: ListView(
                  padding: EdgeInsets.all(20.0),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: _email,
                      //onChanged: (value) { _email.text = value; },
                      keyboardType: TextInputType.emailAddress,
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
                        if(!Validator.validateEmail(_email.text)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _password,
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

                        },
                        child: Text("Esqueci minha senha", style: TextStyle(color: ColorConstant.colorMainOrange),),
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    GestureDetector(
                      onTap: () {

                        formKey.currentState.validate();

                        // if(_email.text.isNotEmpty && _password.text.isNotEmpty) {
                        //   setState(() {
                        //     _errorMessage = '';
                        //   });
                        //   context.read<AuthenticationManager>().signIn(Usuario(email: _email.text, password: _password.text));
                        //   _loginUser();
                        // } else {
                        //   setState(() {
                        //     _validate = true;
                        //   });
                        // }
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
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              )
            ),
          ),
          // Positioned(
          //   bottom: 350.0,
          //   left: 72.0,
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: 267.0,
          //         height: (_validate && _email.text.isEmpty) || _errorMessage == 'E-mail inválido' ? 60.0 : 40.0,
          //         child: TextFormField(
          //           controller: _email,
          //           //onChanged: (value) { _email.text = value; },
          //           keyboardType: TextInputType.emailAddress,
          //           obscureText: false,
          //           decoration: InputDecoration(
          //               border: OutlineInputBorder(),
          //               hintText: "E-mail...",
          //               focusedBorder: OutlineInputBorder(
          //                   borderSide: BorderSide(color: ColorConstant.colorMainOrange)
          //               ),
          //             errorText: _validate && _email.text.isEmpty ? 'Campo obrigatório' : _errorMessage == 'E-mail inválido' ? _errorMessage : null,
          //           ),
          //           // validator: (email) {
          //           //   if(Validator.validateEmail(_email.text)) {
          //           //     return 'E-mail inválido';
          //           //   }
          //           //   return null;
          //           // },
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // Positioned(
          //   bottom: 283.0, //198
          //   left: 72.0, //72
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: 267.0,
          //         height: _validate && _password.text.isEmpty || _errorMessage == 'E-mail e/ou senha não conferem' ? 60.0 : 40.0,
          //         child: TextFormField(
          //           controller: _password,
          //           keyboardType: TextInputType.visiblePassword,
          //           obscureText: true,
          //           decoration: InputDecoration(
          //               hintText: "Senha...",
          //             border: OutlineInputBorder(),
          //               focusedBorder: OutlineInputBorder(
          //                   borderSide: BorderSide(color: ColorConstant.colorMainOrange)
          //               ),
          //             errorText: _validate && _password.text.isEmpty ? 'Campo obrigatório' : _errorMessage == "E-mail e/ou senha não conferem" ? _errorMessage : null,
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // Positioned(
          //   bottom: 218.0, //198
          //   left: 72.0, //72
          //   child: GestureDetector(
          //     onTap: () {
          //       if(_email.text.isNotEmpty && _password.text.isNotEmpty) {
          //         setState(() {
          //           _errorMessage = '';
          //         });
          //         context.read<AuthenticationManager>().signIn(Usuario(email: _email.text, password: _password.text));
          //         _loginUser();
          //       } else {
          //         setState(() {
          //           _validate = true;
          //         });
          //       }
          //     },
          //     child: AnimatedContainer(
          //       alignment: Alignment.center,
          //       width: 267.0,
          //       height: 40.0,
          //       duration: Duration(milliseconds: 5000),
          //       curve: Curves.fastOutSlowIn,
          //       decoration: BoxDecoration(
          //           color: ColorConstant.colorMainOrange,
          //           borderRadius: BorderRadius.all(Radius.circular(5.0))
          //       ),
          //       child: Text(
          //         "Entrar",
          //         style: TextStyle(
          //             color: Colors.white
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
