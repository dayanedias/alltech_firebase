import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String uid;
  String nome;
  String email;
  String password;
  String regional;

  Usuario({ this.uid, this.nome, this.email, this.password, this.regional });
  //
  // factory Usuario.fromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data();
  //
  //   return Usuario(
  //     //id: doc.id,
  //     nome: data['nome'] ?? "",
  //     email: data['email'] ?? "",
  //     regional: data['regional'] ?? "",
  //     password: data["password"] ?? ""
  //   );
  // }

}