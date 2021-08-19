import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Usuario _userFromFirebaseUser(User user) {
  //   return user != null ? Usuario(uid: user.uid) : null;
  // }

  Future <void> signIn(Usuario usuario) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: usuario.email,
          password: usuario.password
      );
      User user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {

      } else if (e.code == 'user-not-found') {

      }
    }
  }

}