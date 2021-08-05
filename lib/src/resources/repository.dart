import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_resources.dart';

class Repository {
  final _authResources = AuthenticationResources();

  //Authentication
  Stream<User> get onAuthStateChange => _authResources.onAuthStateChange;
}