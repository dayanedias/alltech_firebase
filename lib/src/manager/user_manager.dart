import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/utils/firebase_errors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserManager extends ChangeNotifier {
  UserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Usuario user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn({Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: usuario.email, password: usuario.password);

      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
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
      user = usuario;
      await usuario.saveData(usuario.uid);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
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