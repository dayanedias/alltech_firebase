//import 'package:alltech_app/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  int filtroSelecionado = 1;
  String regionalSelecionada = 'Regionais';

  @override
  Widget build(BuildContext context) {
    //final rankingP = Provider.of<RankingProvider>(context);
    //final regionalP = Provider.of<RegionalProvider>(context);

    void _trocarFiltroSelecionado(filtro) {
      return setState(() {
        filtroSelecionado = filtro;
      });
    }

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Ranking - ${regionalSelecionada == "Regionais" ? "Geral" : "Regional ${regionalSelecionada}"}",
                  style: TextStyle(
                      color: Color.fromRGBO(36, 18, 179, 1),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Maio/2021",
                  style: TextStyle(
                      color: Color.fromRGBO(134, 134, 140, 1), fontSize: 10.0),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: filtroSelecionado == 1
                                    ? Colors.deepOrangeAccent
                                    : Color.fromRGBO(189, 189, 189, 0.39),
                                width: 2),
                          )),
                      child: TextButton(
                        child: Text(
                          "Geral",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0),
                        ),
                        onPressed: () {
                          _trocarFiltroSelecionado(1);
                          regionalSelecionada = "Regionais";
                        },
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: filtroSelecionado == 2
                                      ? Colors.deepOrangeAccent
                                      : Color.fromRGBO(189, 189, 189, 0.39),
                                  width: 2),
                            )),
                        child: Center(
                          child: DropdownButton<String>(
                            value: regionalSelecionada,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 20.0,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12.0),
                            underline: Container(
                              height: 0,
                              padding: EdgeInsets.only(top: 3.0),
                              color: Colors.deepOrangeAccent,
                            ),
                            items: <String>[
                              'Regionais',
                              'Nordeste',
                              'Rio Grande do Sul',
                              'Cerrado',
                              'PR/SC/MS',
                              'Mato Grosso',
                              'Triângulo Mineiro',
                              'SP Leste',
                              'SP Oeste',
                              'RJ/ES/MG',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (e) {
                              _trocarFiltroSelecionado(2);
                              regionalSelecionada = e;
                            },
                          ),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: filtroSelecionado == 3
                                    ? Colors.deepOrangeAccent
                                    : Color.fromRGBO(189, 189, 189, 0.39),
                                width: 2),
                          )),
                      child: TextButton.icon(
                        label: Text("Data",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0)),
                        onPressed: () {
                          _trocarFiltroSelecionado(3);
                        },
                        icon: Icon(
                          Icons.date_range_outlined,
                          color: Colors.black,
                          size: 20.0,
                        ),
                      ),
                    ),
                    //CalendarDatePicker(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now(), onDateChanged: (e) {}),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  color: Color.fromRGBO(189, 189, 189, 0.39),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ListView.builder(
                        itemCount: 3, //map do array
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  color: Colors
                                      .white, //index < 3 ? Colors.blue : Colors.grey,
                                  elevation: 5.0,
                                  margin: index == 0
                                      ? EdgeInsets.only(bottom: 15.0)
                                      : EdgeInsets.only(bottom: 0.3),
                                  child: Container(
                                    //width: MediaQuery.of(context).size.width,
                                    height: index == 0 ? 80.0 : 60.0,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                bottomLeft: Radius.circular(5.0)),
                                            color: Colors.deepOrangeAccent,
                                          ),
                                          child: Center(
                                            child: index == 0
                                                ? AssetImage('images/trofeu.png')
                                                : Text(
                                              "${(index + 1).toString()}º",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10.0, top: 10.0),
                                                    width: 30.0,
                                                    height: 30.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: AssetImage(
                                                              'images/images.png')),
                                                    )),
                                                Flexible(
                                                  child: Container(
                                                    //alignment: Alignment.bottomLeft,
                                                    margin: EdgeInsets.only(
                                                        left: 10.0, top: 10.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Participante ${index + 1}",
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                        ),
                                                        //Text(rankingP.ranking[index].usuario_criacao.toString()),
                                                        Text(
                                                          "Regional ${index + 1}",
                                                          style:
                                                          TextStyle(fontSize: 10.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Container(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(30.0),
                                                color: index == 0
                                                    ? Colors.deepOrangeAccent
                                                    : Color.fromRGBO(
                                                    51, 51, 51, 0.88)),
                                            margin: EdgeInsets.only(
                                                top: 5.0, right: 10.0),
                                            padding: EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                Text((10 * (index + 1)).toString(),
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: index == 0
                                                            ? Colors.black
                                                            : Colors.white)),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  "Pontos",
                                                  style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: index == 0
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                                //Text(rankingP.ranking[index].usuario_criacao.toString()),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
