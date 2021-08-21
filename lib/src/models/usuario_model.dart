import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String uid;
  String nome;
  String email;
  String documento;
  String password;
  String regional;
  String foto;
  DateTime data_inicio;
  bool admin;

  Usuario({ this.uid, this.nome, this.email, this.documento, this.password, this.regional, this.admin, this.foto });

  Usuario.fromDocument(DocumentSnapshot document){
    uid = document.data()['uid'] as String;
    nome = document.data()['nome'] as String ?? '';
    email = document.data()['email'] as String ?? '';
    regional = document.data()['regional'] as String ?? '';
    foto = document.data()['foto'] as String ?? '';
    admin = document.data()['admin'] as bool ?? false;
  }

  CollectionReference get firestoreRef => FirebaseFirestore.instance.collection('usuario');

  Future <void> saveData(String uid) async {
    await firestoreRef.doc(uid).set(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'nome': nome,
      'email': email,
      'documento': documento,
      'data_inicio': DateTime.now(),
      'admin': admin,
      'foto' : foto,
      'password': password
    };
  }

}