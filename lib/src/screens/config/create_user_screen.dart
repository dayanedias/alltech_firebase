import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/screens/widgets/change_profile_picture.dart';
import 'package:alltech_new_firebase/src/utils/helpers.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  FocusNode myFocusNode = FocusNode();
  String regionalSelecionada;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
                    //ChangeProfilePicture(),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      //height: 42.0,
                      child:                     TextFormField(
                          controller: _nome,
                          enabled: !userManager.loading,
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.5, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            labelText: "Nome completo",
                            //hintText: "Nome completo",
                            labelStyle:
                            TextStyle(color: ColorConstant.colorInputFont),
                            //hintText: "Insira o nome completo",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstant.colorMainOrange)),
                          ),
                          validator: (nome) {
                            if (nome.isEmpty)
                              return 'Campo obrigatório';
                            else if (nome.trim().split(' ').length <= 1)
                              return 'Insira o nome completo';
                            return null;
                          },
                          onSaved: (nome) => user.nome = _nome.text),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      //height: 42.0,
                      child: TextFormField(
                        controller: _documento,
                        enabled: !userManager.loading,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.5, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          labelText: "Documento",
                          //TODO: Mudar a cor do texto quando selecionado
                          labelStyle:
                              TextStyle(color: ColorConstant.colorInputFont),
                          //hintText: "Insira o documento",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstant.colorMainOrange)),
                        ),
                        validator: (doc) {
                          if (doc.isEmpty) return 'Campo obrigatório';
                          return null;
                        },
                        onSaved: (doc) => user.documento = _documento.text,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      //height: 42.0,
                      child: TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        enabled: !userManager.loading,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.5, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          labelText: "E-mail",
                          labelStyle:
                              TextStyle(color: ColorConstant.colorInputFont),
                          //hintText: "Insira o e-mail",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstant.colorMainOrange)),
                        ),
                        validator: (email) {
                          if (email.isEmpty) return 'Campo obrigatório';
                          if (!Helpers.validateEmail(_email.text)) {
                            return 'E-mail inválido';
                          }
                          return null;
                        },
                        onSaved: (email) => user.email = _email.text,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("regional")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          Text("Carregando");
                        } else {
                          List<DropdownMenuItem> regionalItems = [];
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            DocumentSnapshot regional = snapshot.data.docs[i];
                            regionalItems.add(DropdownMenuItem(
                              child: Container(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  regional['nome_regional'],
                                ),
                              ),
                              value: "${regional['nome_regional']}",
                            ));
                          }
                          return Container(
                            height: 42.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            child: DropdownButton(
                              items: regionalItems,
                              onChanged: (selectedRegional) {
                                setState(() {
                                  user.regional = selectedRegional;
                                  regionalSelecionada = selectedRegional;
                                });
                              },
                              value: regionalSelecionada,

                              isExpanded: true,
                              underline: Container(
                                height: 0,
                              ),
                              hint: Container(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Selecione a regional",
                                  style: TextStyle(
                                      color: ColorConstant.colorInputFont),
                                ),
                              ),
                            ),
                          );
                        }
                        return Text("Carregando");
                      },
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    CheckboxListTile(
                        contentPadding: EdgeInsets.only(left: 3.0, right: 0.0),
                        title: Text(
                          'Administrador',
                          style: TextStyle(color: ColorConstant.colorMainFont),
                        ),
                        checkColor: ColorConstant.colorMainBackground,
                        value: _adm,
                        onChanged: (e) {
                          setState(() {
                            _adm = !_adm;
                            user.admin = _adm;
                          });
                        }),
                    SizedBox(
                      height: 16.0,
                    ),
                    MaterialButton(
                      elevation: 5.0,
                      height: 42.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: ColorConstant.colorMainOrange,
                      child: Text(
                        "CADASTRAR",
                        style: TextStyle(
                          color: ColorConstant.colorButtonFont,
                          fontSize: 14.0,
                        ),
                      ),
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                // user.password = Helpers
                                //     .generatePassword(); //TODO: Descomentar o gerador de senha
                                user.password = '123456';
                                userManager.signUp(
                                    usuario: user,
                                    onFail: (e) {
                                      scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text("${e}"),
                                        backgroundColor: Colors.red,
                                      ));
                                    },
                                    onSuccess: () {
                                      scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text("Usuário cadastrado com sucesso!"),
                                        backgroundColor: Colors.green,
                                      ));
                                      Navigator.of(context).pop();
                                    });
                              }
                            },
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
