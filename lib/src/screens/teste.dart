import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseFirestore.instance.collection("users").doc("doc").set({"texto":"Dayane", "id": "01"});

    return Container();
  }
}
