import 'package:alltech_new_firebase/src/screens/home/home_screen.dart';
import 'package:alltech_new_firebase/src/screens/navigation/perfil_screen.dart';
import 'package:alltech_new_firebase/src/screens/navigation/premio_screen.dart';
import 'package:alltech_new_firebase/src/screens/navigation/publicar_screen.dart';
import 'package:alltech_new_firebase/src/screens/navigation/ranking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  ];

  final title = [
    Center(child: Text('Início')),
    Center(child: Text('Ranking')),
    Center(child: Text('Publicar')),
    Center(child: Text('Premiação')),
    Center(child: Text('Perfil')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alltech"), //title[_currentIndex],
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepOrangeAccent,
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
  }
}
