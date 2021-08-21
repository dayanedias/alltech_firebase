import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/screens/home/home_screen.dart';
import 'package:alltech_new_firebase/src/screens/navigation/config_screen.dart';
import 'package:alltech_new_firebase/src/screens/navigation/perfil_screen.dart';
import 'package:alltech_new_firebase/src/screens/navigation/premio_screen.dart';
import 'package:alltech_new_firebase/src/screens/navigation/publicar_screen.dart';
import 'package:alltech_new_firebase/src/screens/navigation/ranking_screen.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationBarWidget extends StatefulWidget {
  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int _currentIndex = 0;

  final tabs = [
    HomeScreen(),
    RankingScreen(),
    PublicarScreen(),
    PremioScreen(),
    PerfilPage(),
    ConfigScreeen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Consumer<UserManager>(
      builder: (context, userManager, __){
        return Scaffold(
          // appBar: AppBar(
          //   title: Text("Alltech"), //title[_currentIndex],
          //   backgroundColor: ColorConstant.colorMainOrange,
          //   centerTitle: true,
          // ),
          //body: _currentIndex != 4 ? tabs[_currentIndex] : userManager.user.admin ? tabs[_currentIndex+1] : tabs[_currentIndex], //TODO: Descomentar para buildar
          body: tabs[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: ColorConstant.colorMainOrange,
            currentIndex: _currentIndex,
            fixedColor: Colors.white,
            iconSize: 20,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Início"),
              ),
              BottomNavigationBarItem(icon: Icon(Icons.star), title: Text("Ranking")),
              BottomNavigationBarItem(icon: Icon(Icons.add_circle), title: Text("Publicar")),
              BottomNavigationBarItem(icon: Icon(Icons.emoji_events), title: Text("Premiação")),
              BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Perfil")),
              BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text("Config")),
              //BottomNavigationBarItem(icon: userManager.user.admin ? Icon(Icons.settings) : Icon(Icons.person), title: userManager.user.admin ? Text("Config") : Text("Perfil") ), // TODO: Descomentar para buildar
            ],
            onTap: (index) {
              setState(() {
                if(index == 2) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PublicarScreen())
                  );
                } else {
                  _currentIndex = index;
                }
              });
            },
          ),
        );
      },
    );
  }
}
