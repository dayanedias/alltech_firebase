import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/screens/config/create_premio_screen.dart';
import 'package:alltech_new_firebase/src/screens/config/create_tipo_atividade_screen.dart';
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
                  height: 42.0,
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0) ),
                  color: ColorConstant.colorMainOrange,
                  child: Text("CRIAR NOVO USUÁRIO", style: TextStyle(
                    color: ColorConstant.colorButtonFont,
                    fontSize: 14.0,
                  )),
                    onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CreateUserScreen())
                        );
                    }),
                SizedBox(height: 12.0,),
                MaterialButton(
                    elevation: 5.0,
                    height: 42.0,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0) ),
                    color: ColorConstant.colorMainOrange,
                    child: Text("CRIAR NOVO TIPO DE ATIVIDADE", style: TextStyle(
                      color: ColorConstant.colorButtonFont,
                      fontSize: 14.0,
                    )),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CreateTipoAtividadeScreen())
                      );
                    }),
                SizedBox(height: 12.0,),
                MaterialButton(
                    elevation: 5.0,
                    height: 42.0,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0) ),
                    color: ColorConstant.colorMainOrange,
                    child: Text("CRIAR NOVA PREMIAÇÃO", style: TextStyle(
                      color: ColorConstant.colorButtonFont,
                      fontSize: 14.0,
                    )),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CreatePremioScreen())
                      );
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
