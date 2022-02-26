import 'package:alltech_new_firebase/src/manager/tipo_atividade_manager.dart';
import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/models/tipo_atividade_model.dart';
import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTipoAtividadeScreen extends StatefulWidget {
  @override
  _CreateTipoAtividadeScreenState createState() => _CreateTipoAtividadeScreenState();
}

class _CreateTipoAtividadeScreenState extends State<CreateTipoAtividadeScreen> {
  final _nomeAtividade = TextEditingController();
  final _pontuacao = TextEditingController();
  final TipoAtividade tipoAtividade = TipoAtividade();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Novo tipo de atividade"),
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
            child: Consumer<TipoAtividadeManager>(
              builder: (context, tipoAtividadeManager, __) {
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
                          controller: _nomeAtividade,
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.5, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            labelText: "Nome da atividade",
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
                          onSaved: (nome) => tipoAtividade.descricao = _nomeAtividade.text),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      //height: 42.0,
                      child: TextFormField(
                        controller: _pontuacao,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.5, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          labelText: "Pontuação",
                          //TODO: Mudar a cor do texto quando selecionado
                          labelStyle:
                          TextStyle(color: ColorConstant.colorInputFont),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstant.colorMainOrange)),
                        ),
                        validator: (doc) {
                          if (doc.isEmpty) return 'Campo obrigatório';
                          return null;
                        },
                        onSaved: (doc) => tipoAtividade.pontos = int.parse(_pontuacao.text),
                      ),
                    ),
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
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          print("TIPO ATIVIDADE =>> ${tipoAtividade.descricao}");
                          tipoAtividadeManager.createTipoAtividade(
                            tipoAtividade: tipoAtividade,
                              onFail: (e) {
                                scaffoldKey.currentState
                                    .showSnackBar(SnackBar(
                                  content: Text("${e}"),
                                  backgroundColor: Colors.red,
                                ));
                              },
                              onSuccess: () {
                              print("SUCESSO!");
                                scaffoldKey.currentState
                                    .showSnackBar(SnackBar(
                                  content: Text("Tipo de atividade cadastrada com sucesso!"),
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
