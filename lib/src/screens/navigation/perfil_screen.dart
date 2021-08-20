import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  //var user = Provider.of<User>(context);
  //final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('usuario').snapshots();
  bool _comentarios = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Consumer<UserManager>(
        builder: (context, userManager, __){
          return Text(userManager.user?.nome);
        },
      ),
    );
  }
}
