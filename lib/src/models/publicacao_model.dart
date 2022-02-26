import 'package:cloud_firestore/cloud_firestore.dart';

class Publicacao{
  DocumentReference uui;
  CollectionReference atividades;
  bool ativo;
  String localizacao;
  //DateTime data_inicio;
  String descricao;
  CollectionReference midia;
  DateTime data_inicio;


  Publicacao({ this.uui, this.ativo, this.atividades, this.localizacao, this.descricao, this.midia, this.data_inicio });

}