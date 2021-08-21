import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _atualSenha = TextEditingController();
  final _novaSenha = TextEditingController();
  final _novaSenhaConfirmacao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Troca de senha"),
        centerTitle: true,
        backgroundColor: ColorConstant.colorMainOrange,
      ),
      body: Center(
        child: Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            child: Consumer<UserManager>(
              builder: (context, userManager, __) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: _atualSenha,
                      //enabled: !userManager.loading,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Senha atual",
                        hintText: "Digite a senha atual",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                        ),
                      ),
                      validator: (senhaatual){
                        if(senhaatual.isEmpty)
                          return 'Campo obrigatório';
                        return null;
                      },
                      //onSaved: (nome) => user.nome = _nome.text
                    ),
                    SizedBox(height: 16.0),
                  TextFormField(
                  controller: _novaSenha,
                  //enabled: !userManager.loading,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nova senha",
                    hintText: "Digite uma nova senha",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                    ),
                  ),
                  validator: (senha1){
                    if(senha1.isEmpty)
                      return 'Campo obrigatório';
                    return null;
                  },
                  //onSaved: (nome) => user.nome = _nome.text
                  ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _novaSenhaConfirmacao,
                      //enabled: !userManager.loading,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Confirme a nova senha",
                        hintText: "Confirme a nova senha",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                        ),
                      ),
                      validator: (senha2){
                        if(senha2.isEmpty)
                          return 'Campo obrigatório';
                        return null;
                      },
                      //onSaved: (nome) => user.nome = _nome.text
                    ),
                    SizedBox(height: 16.0),
                    GestureDetector(
                        // onTap: userManager.loading ? null : () {
                        //   if(formKey.currentState.validate()) {
                        //     userManager.signIn(
                        //         usuario: Usuario(
                        //             email: _email.text,
                        //             password: _password.text
                        //         ),
                        //         onFail: (e) {
                        //           scaffoldKey.currentState.showSnackBar(
                        //               SnackBar(content: Text("${e}"),
                        //                 backgroundColor: Colors.red,
                        //               )
                        //           );
                        //         },
                        //         onSuccess: () {
                        //           print("Sucesso!");
                        //         }
                        //     );
                        //   }
                        // },
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
                              "Confirmar",
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
            ),
          ),
        ),
      );
  }
}
