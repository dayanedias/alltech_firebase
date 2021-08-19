import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  String _email;
  String _password;
  String _nome;

  Future<void> _createUser() async {
    try {
      //UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Senha fraca');
      } else if (e.code == 'email-already-in-use') {
        print('Já existe um usuário cadastrado para esse e-mail');
      }
    } catch (e) {
      print("Error $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar novo usuário"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) { _email = value; },
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: InputDecoration(
                    hintText: "Login...",
                    border: OutlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                    )
                ),
              ),
              SizedBox(height: 16.0,),
              TextField(
                onChanged: (value) { _password = value; },
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Senha...",
                    border: OutlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorConstant.colorMainOrange)
                    )
                ),
              ),
              SizedBox(height: 16.0,),
              MaterialButton(
                onPressed: _createUser,
                child: Text("Criar novo usuário"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
