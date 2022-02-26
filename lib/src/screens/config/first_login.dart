import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/screens/widgets/change_profile_picture.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstLogin extends StatefulWidget {
  @override
  _FirstLoginState createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> {
  final _atualSenha = TextEditingController();
  final _novaSenha = TextEditingController();
  final _novaSenhaConfirmacao = TextEditingController();
  final Usuario user = Usuario();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Primeiro login"),
        centerTitle: true,
        backgroundColor: ColorConstant.colorMainOrange,
      ),
      body: Center(
        child: Card(
          elevation: 0,
          color: ColorConstant.colorMainBackground,
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (context, userManager, __) {
                return ListView(
                  children: [
                    SizedBox(height: 20.0),
                    ChangeProfilePicture(),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _novaSenha,
                      //enabled: !userManager.loading,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nova senha",
                        //hintText: "Digite uma nova senha",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                        ),
                      ),
                      validator: (senha1){
                        if(senha1.isEmpty)
                          return 'Campo obrigatório';
                        if(senha1.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      //onSaved: (nome) => user.nome = _nome.text
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _novaSenhaConfirmacao,
                      //enabled: !userManager.loading,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Confirme a nova senha",
                        //hintText: "Confirme a nova senha",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                        ),
                      ),
                      validator: (senha2){
                        if(senha2.isEmpty)
                          return 'Campo obrigatório';
                        if(senha2.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      //onSaved: (nome) => user.nome = _nome.text
                    ),
                    SizedBox(height: 16.0),
                    MaterialButton(
                        elevation: 5.0,
                        height: 50.0,
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0) ),
                        color: ColorConstant.colorMainOrange,
                        child: Text("Confirmar", style: TextStyle(color: ColorConstant.colorMainBackground, fontSize: 18.0),),
                        onPressed: () {
                          if(formKey.currentState.validate()){
                            if(_novaSenha.text == _novaSenhaConfirmacao.text) {
                              userManager.user.first_login = false;
                              userManager.changePassword();
                              Navigator.of(context).pop();
                            } else {
                              print("SENHAS não conferem"); //TODO: Fazer resposta de erro ao usuário
                            }
                          }
                        }
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
