import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/screens/config/create_user_screen.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ConfigScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.colorMainOrange,
        title: Text("Configurações"),
        centerTitle: true,
      ),
      body: Consumer<UserManager>(
        builder: (context, userManager, __){
          return Card(
            elevation: 0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: ListView(
              children: [
                MaterialButton(
                  elevation: 5.0,
                  height: 40.0,
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0) ),
                  color: ColorConstant.colorMainOrange,
                  child: Text("Criar novo usuário", style: TextStyle(color: ColorConstant.colorMainBackground, fontSize: 16.0),),
                    onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CreateUserScreen())
                        );
                    }
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
