import 'package:alltech_new_firebase/src/models/premio_model.dart';
import 'package:alltech_new_firebase/src/utils/firebase_errors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PremioManager extends ChangeNotifier{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference get firestoreRef => FirebaseFirestore.instance.collection('premio');

  Future <void> createPremio ({Premio premio, Function onFail, Function onSuccess}) async {
    try {
      await firestoreRef.doc(premio.nome_premio).set({
        'nome_premio': premio.nome_premio,
        'descricao': premio.descricao,
        'foto_premio': premio.foto_premio,
        'data_inicio_premio': premio.data_inicio_premio,
        'data_fim_premio': premio.data_fim_premio,
        'data_inicio': DateTime.now()
      });
      onSuccess();
    } on FirebaseException catch (e) {
      print("ERROR =>> ${e.code}");
      onFail(getErrorString(e.code));
    }

  }

}