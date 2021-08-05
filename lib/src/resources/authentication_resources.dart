import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationResources {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get onAuthStateChange => _firebaseAuth.authStateChanges();

}