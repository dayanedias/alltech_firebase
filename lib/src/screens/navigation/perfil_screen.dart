import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  //var user = Provider.of<User>(context);
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('usuario').snapshots();
  bool _comentarios = false;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, snapshot) {
        if (snapshot.hasError) {
          print ("Deu erro");
        }

        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorConstant.colorMainFont,
            ),
          );
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['nome']),
              subtitle: Text(data['email']),
            );
          }).toList(),
        );
    }
    );
  }
}
