import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/manager/publicacao_manager.dart';
import 'package:alltech_new_firebase/src/screens/home/first_login_alert.dart';
import 'package:alltech_new_firebase/src/screens/widgets/publicacao_widget.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  //static const String routeName = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.colorMainOrange,
        title: Text("Alltech"),
        centerTitle: true,
      ),
      backgroundColor: ColorConstant.colorMainBackground,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Consumer2<UserManager, PublicacaoManager>(
          builder: (context, userManager, publicacaoManager, child) {
            if (userManager.user != null) {
              return Container(
                child: Center(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('publicacao').snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData) return Text("Carregando feed... Aguarde");
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = snapshot.data.docs[index];
                            print(ds.data()['uid']);
                            print(ds['usuario']['nome']);
                            return Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              // child: PublicacaoWidget(nome_usuario: userManager.user.nome, regional_usuario: userManager.user.regional, foto_usuario: userManager.user.foto,),
                              child: ds['ativo'] ?
                              PublicacaoWidget(
                                uid_usuario: ds["uid"],
                                nome_usuario: ds['usuario']['nome'],
                                regional_usuario: ds['usuario']['regional'],
                                foto_usuario: ds['usuario']['foto'],
                                descricao: ds['descricao'],
                                data_post: ds['data_inicio'],
                                atividades: ds['atividades'] ?? ds['atividades'],
                                //midia: ds['midia'] ?? ds['midia'],
                                // comentarios: ds['comentarios'] ?? ds['comentarios'],
                                // documentos: ds['documentos'] ?? ds['documentos'],
                                // foto: ds['foto'] ?? ds['foto'],
                                // quiz: ds['quiz'] ?? ds['quiz'],
                                )
                              :

                              null
                            );
                          },
                      );
                    },
                  )
                ),
              );
            }
            return CircularProgressIndicator(
              color: ColorConstant.colorMainFont,
            );
          },
        ),
      ),
    );
  }
}