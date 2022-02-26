import 'package:alltech_new_firebase/src/models/tipo_atividade_model.dart';
import 'package:alltech_new_firebase/src/utils/firebase_errors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TipoAtividadeManager extends ChangeNotifier {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference get firestoreRef => FirebaseFirestore.instance.collection('tipo_atividade');

  //TipoAtividade tipoAtividade;

  Future <void> createTipoAtividade ({TipoAtividade tipoAtividade, Function onFail, Function onSuccess}) async {
    try {
      await firestoreRef.doc(tipoAtividade.descricao).set({
        'ativo': true,
        'descricao': tipoAtividade.descricao,
        'pontos': tipoAtividade.pontos,
        'data_inicio': DateTime.now()
      });
      onSuccess();
    } on FirebaseException catch (e) {
      print("ERROR =>> ${e.code}");
      onFail(getErrorString(e.code));
    }

  }


}