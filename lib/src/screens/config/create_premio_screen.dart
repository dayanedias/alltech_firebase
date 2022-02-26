import 'package:alltech_new_firebase/src/manager/premio_manager.dart';
import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/models/premio_model.dart';
import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/screens/widgets/change_profile_picture.dart';
import 'package:alltech_new_firebase/src/utils/helpers.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePremioScreen extends StatefulWidget {
  @override
  _CreatePremioScreenState createState() => _CreatePremioScreenState();
}

class _CreatePremioScreenState extends State<CreatePremioScreen> {
  final _nomePremio = TextEditingController();
  final _descricao = TextEditingController();

  final Premio premio = Premio();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Nova premiação"),
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
            child: Consumer<PremioManager>(
              builder: (context, premioManager, __) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    //ChangeProfilePicture(),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      //height: 42.0,
                      child: TextFormField(
                          controller: _nomePremio,
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.5, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            labelText: "Nome do prêmio",
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
                            return null;
                          },
                          onSaved: (nome) => premio.nome_premio = _nomePremio.text),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      //height: 42.0,
                      child: TextFormField(
                        controller: _descricao,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.5, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          labelText: "Descrição",
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
                        onSaved: (doc) => premio.descricao = _descricao.text,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
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
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          premioManager.createPremio(
                              premio: premio,
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
                                  content: Text("Prêmio cadastrado com sucesso!"),
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
