import 'dart:io';

import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/utils/firebase_errors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class UserManager extends ChangeNotifier {
  UserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference get firestoreRef => FirebaseFirestore.instance.collection('usuario');

  Usuario user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn({Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: usuario.email, password: usuario.password);
      await _loadCurrentUser(firebaseUser: result.user);
      loading = false;
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
      loading = false;
    }
    loading = false;
  }

  Future<void> signUp({Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.password,
      );
      usuario.uid = result.user.uid;
      //user = usuario; //Troca para o usuário criado
      await usuario.saveData(usuario.uid);
      loading = false;
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
      loading = false;
    }
    loading = false;
  }

  Future<void> signOut({Usuario usuario, Function onFail, Function onSuccess}) async {
    // loading = true;
    try {
      await FirebaseAuth.instance.signOut();
      onSuccess();
      loading = false;
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
      loading = false;
    }
    loading = false;
  }

  Future<void> resetPassword({Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: usuario.email,);
      loading = false;
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
      loading = false;
    }
    loading = false;
  }

  Future<void> changePassword({Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      await auth.currentUser.updatePassword(usuario.password).then((value) => print("MUDOU A SENHA"));
      loading = false;
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
      print("ERROR - ${e.code}");
      loading = false;
    }
    loading = false;
  }

  Future<void> updateFirstLoginUser({Usuario usuario, Function onFail, Function onSuccess}) async { //TODO: Terminar de criar a função de update considerando que o usuário só pode alterar a foto
    loading = true;
    try {
      await firestoreRef.doc(user.uid).update({
        'first_login': false,
      });
      loading = false;
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
      loading = false;
    }
    loading = false;
  }

  Future<void> updateFotoUser({Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      await firestoreRef.doc(user.uid).update({
        'foto': user.foto,
      });
      //await usuario.updateFoto(user.uid);
      //user = usuario;
      loading = false;
      onSuccess();
     } on FirebaseException catch (e) {
       onFail(getErrorString(e.code));
       loading = false;
     }

    loading = false;

  }


  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser = await firestore.collection('usuario').doc(currentUser.uid).get();
      user = Usuario.fromDocument(docUser);
    }
    notifyListeners();
  }
}