import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/screens/config/change_password.dart';
import 'package:alltech_new_firebase/src/screens/widgets/change_profile_picture.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.colorMainOrange,
        title: Text("Perfil"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (e) {
              if(e == 'Sair') context.read<UserManager>().signOut();
              if(e == "Trocar senha") { Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChangePassword())
              );}
            },
            itemBuilder: (BuildContext context) {
              return {'Sair', 'Trocar senha'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Consumer<UserManager>(
            builder: (context, userManager, __) {
              return Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20.0,),
                      ChangeProfilePicture(),
                      SizedBox(height: 16.0,),
                      Text(
                        userManager.user.nome, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0,),
                      Text(userManager.user.regional.isNotEmpty ? userManager.user.regional : '', style: TextStyle(fontSize: 12.0),),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          children: [
                            Container(
                              //alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width * 0.30,
                                decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: ColorConstant.colorMainOrange, width: 2),
                                    )),
                                child: Center(
                                  child: Text("Publicações",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.60,
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromRGBO(189, 189, 189, 0.39),
                                        width: 2),
                                  )),
                              child: Text(
                                "",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}
