import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/utils/helpers.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _nome = TextEditingController();
  final _documento = TextEditingController();
  final _email = TextEditingController();
  final _regional = TextEditingController();
  final Usuario user = Usuario();
  bool _adm = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _createUser() async {
    // catch (e) {
    //   print("Error $e");
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo cadastro"),
        centerTitle: true,
        backgroundColor: ColorConstant.colorMainOrange,
      ),
      body: Center(
        child: Card(
          elevation: 0,
          color: ColorConstant.colorMainBackground,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (context, userManager, __) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: _nome,
                      enabled: !userManager.loading,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nome",
                        hintText: "Insira o nome completo",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                        ),
                      ),
                      validator: (nome){
                        if(nome.isEmpty)
                          return 'Campo obrigatório';
                        else if(nome.trim().split(' ').length <= 1)
                          return 'Insira o nome completo';
                        return null;
                      },
                      onSaved: (nome) => user.nome = _nome.text
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _documento,
                      enabled: !userManager.loading,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Documento", //TODO: Mudar a cor do texto quando selecionado
                        hintText: "Insira o documento",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                        ),
                      ),
                      validator: (doc) {
                        if(doc.isEmpty)
                          return 'Campo obrigatório';
                        return null;
                      },
                      onSaved: (doc) => user.documento = _documento.text,
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      enabled: !userManager.loading,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "E-mail",
                        hintText: "Insira o e-mail",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                        ),
                      ),
                      validator: (email) {
                        if(email.isEmpty)
                          return 'Campo obrigatório';
                        if(!Helpers.validateEmail(_email.text)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                      onSaved: (email) => user.email = _email.text,
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(  //TODO: Trocar para um select
                      controller: _regional,
                      enabled: !userManager.loading,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Regional",
                        hintText: "Selecione a Regional",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                        ),
                      ),
                      validator: (regional) {
                        if(regional.isEmpty)
                          return 'Campo obrigatório';
                        return null;
                      },
                      onSaved: (regional) => user.regional = _regional.text,
                    ),
                    SizedBox(height: 16.0,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text("Administrador", style: TextStyle(color: ColorConstant.colorMainFont),),
                            )
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                                checkColor: ColorConstant.colorMainBackground,
                                value: _adm,
                                onChanged: (e){
                                  setState(() {
                                    _adm = !_adm;
                                    user.admin = _adm;
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0,),
                    GestureDetector(
                        onTap: userManager.loading ? null : () {
                          if(formKey.currentState.validate()) {
                            formKey.currentState.save();
                            user.password = Helpers.generatePassword(); //TODO: Descomentar o gerador de senha
                            //user.password = '123456';
                            userManager.signUp(
                                usuario: user,
                                onFail: (e) {
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(content: Text("${e}"),
                                        backgroundColor: Colors.red,
                                      )
                                  );
                                },
                                onSuccess: () {
                                  print("Sucesso!"); //TODO: POP
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
                              "Cadastrar",
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
