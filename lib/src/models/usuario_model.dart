import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Usuario {
  String uid;
  String nome;
  String email;
  String documento;
  String password;
  String regional;
  String foto;
  DateTime data_inicio;
  DateTime data_fim;
  bool admin;
  bool first_login;

  Usuario({ this.uid, this.nome, this.email, this.documento, this.password, this.regional, this.admin, this.foto, this.first_login });

  Usuario.fromDocument(DocumentSnapshot document){
    uid = document.data()['uid'] as String;
    nome = document.data()['nome'] as String ?? '';
    email = document.data()['email'] as String ?? '';
    regional = document.data()['regional'] as String ?? '';
    foto = document.data()['foto'] as String ?? '';
    admin = document.data()['admin'] as bool ?? false;
    first_login = document.data()['first_login'] as bool ?? false;
  }

  CollectionReference get firestoreRef => FirebaseFirestore.instance.collection('usuario');
  FirebaseStorage storage = FirebaseStorage.instance;

  Future <void> updateFirstLogin() async {
    await firestoreRef.doc(uid).update({
      'first_login': false,
    }).then((value) => print("ATUALIZOU FIRST LOGIN")).catchError((error) => print("FALHOU ATUALIZAR"));
  }

  Future <void> saveData(String uid) async {
    await firestoreRef.doc(uid).set(toMap());
  }


  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'nome': nome,
      'email': email,
      'documento': documento,
      'data_inicio': DateTime.now(),
      'admin': admin ?? false,
      'regional': regional,
      'foto' : foto ?? 'https://firebasestorage.googleapis.com/v0/b/acs-interaction-v1.appspot.com/o/profile%2Fimages.png?alt=media&token=a2469419-696f-4a17-8c9a-b9c7aba1b5f2',
      'password': password,
      'first_login': true,
    };
  }

}