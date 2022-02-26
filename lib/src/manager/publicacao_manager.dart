import 'package:alltech_new_firebase/src/models/publicacao_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PublicacaoManager extends ChangeNotifier {
  PublicacaoManager() {
    _loadFeed();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference get firestoreRef => FirebaseFirestore.instance.collection('publicacao');

  Publicacao publicacao;

  Future<void> _loadFeed({Publicacao publicacao}) async {
      final CollectionReference publicacoes = await firestore.collection('publicacao');
      notifyListeners();
  }

}