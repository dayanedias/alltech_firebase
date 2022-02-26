import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PublicacaoWidget extends StatefulWidget {
  final String uid_usuario;
  final String nome_usuario;
  final String regional_usuario;
  final String foto_usuario;
  final String data_post;
  final String descricao;
  final double localizacao;
  final List atividades;
  final List documentos;
  final List midia;
  // final List video;
  final List quiz;
  final List comentarios;

  PublicacaoWidget(
      {Key key,
        @required this.uid_usuario,
        this.regional_usuario,
        this.nome_usuario,
        this.foto_usuario,
        this.data_post,
        this.descricao,
        this.localizacao,
        this.atividades,
        this.documentos,
        this.midia,
        // this.video,
        this.quiz,
        this.comentarios})
      : super(key: key);

  @override
  _PublicacaoWidgetState createState() => _PublicacaoWidgetState(
      uid_usuario,
      nome_usuario,
      regional_usuario,
      foto_usuario,
      data_post,
      descricao,
      localizacao,
      atividades,
      documentos,
      midia,
      // video,
      quiz,
      comentarios);
}

class _PublicacaoWidgetState extends State<PublicacaoWidget> {
  final String uid_usuario;
  final String nome_usuario;
  final String regional_usuario;
  final String foto_usuario;
  final String data_post;
  final String descricao;
  final double localizacao;
  final List atividades;
  final List documentos;
  final List midia;
  // final List video;
  final List quiz;
  final List comentarios;
  bool _comentarios = false;

  _PublicacaoWidgetState(
      this.uid_usuario,
      this.nome_usuario,
      this.regional_usuario,
      this.foto_usuario,
      this.data_post,
      this.descricao,
      this.localizacao,
      this.atividades,
      this.documentos,
      this.midia,
      // this.video,
      this.quiz,
      this.comentarios);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(189, 189, 189, 0.39),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
            child: Row(
              children: [
                Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: foto_usuario == null
                              ? AssetImage('images/images.png')
                              : NetworkImage(foto_usuario)),
                    )),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${nome_usuario}',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      regional_usuario,
                      style: TextStyle(
                          fontSize: 12.0,
                          color: ColorConstant.colorAdmFont),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      //data_post.toString(),
                      DateFormat('dd/MM/yyyy').format(DateTime.parse(data_post.toString())),
                      style: TextStyle(
                          fontSize: 10.0,
                          color: Color.fromRGBO(134, 134, 140, 1)),
                    ),

                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(descricao),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          CarouselSlider(
            options: CarouselOptions(
                height: 250.0,
                autoPlay: false,
              // enableInfiniteScroll: false,
            ),
            items: [1,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.amber
                      ),
                      child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                  );
                },
              );
            }).toList(),
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Row(
                    children: atividades
                        .map((atividade) => Padding(
                      padding: EdgeInsets.only(right: 3.0),
                      child: Container(
                        width: 83.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(40.0)),
                            color: Colors.deepOrangeAccent),
                        child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                atividade["cd_tipo_atividade"]
                                ["descricao_atividade"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                ),
                              ),
                            )),
                      ),
                    ))
                        .toList(),
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: DropdownButton<String>(
                            //value: '',
                            icon: const Icon(
                              Icons.more_vert_outlined,
                              size: 24.0,
                            ),
                            underline: Container(height: 0,),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12.0),

                            items: atividades.map((atividade) {
                              return DropdownMenuItem(
                                value: atividade["cd_tipo_atividade"]
                                ["id"].toString(),
                                child: Text(atividade["cd_tipo_atividade"]
                                ["descricao_atividade"]),
                              );
                            }).toList(),

                            // items: <String>[
                            //   'Regionais',
                            //   'One',
                            //   'Two',
                            //   'Free',
                            //   'Four',
                            // ].map<DropdownMenuItem<String>>((String value) {
                            //   return DropdownMenuItem<String>(
                            //     value: value,
                            //     child: Text(value),
                            //   );
                            // }).toList(),

                            onChanged: (e) {},
                          ),
                        ),
                      )
                  ),
                ],
              )),
          // Container(padding: EdgeInsets.only(left: 20.0, right: 20.0),
          //   child: Image(image: AssetImage('images/plantacao.jpg')),
          // ),
          // Ações: Curtir, comentar
          Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up_alt_rounded),
                          //Icon(Icons.thumb_up_alt_outlined),
                          onPressed: () {},
                        ),
                        Text("8 curtidas",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Color.fromRGBO(134, 134, 140, 1))),
                      ],
                    ),
                    SizedBox(
                      width: 100.0,
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.chat_bubble_outline_outlined),
                          onPressed: () {
                            setState(() {
                              _comentarios = !_comentarios;
                            });
                          },
                        ),
                        Text("4 comentários",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Color.fromRGBO(134, 134, 140, 1))),
                      ],
                    ),
                  ],
                ),
              )),
          if (_comentarios == true)
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide.none,
                            left: BorderSide.none,
                            top: BorderSide(
                                color: Colors.deepOrangeAccent, width: 1.0),
                            bottom: BorderSide(
                                color: Colors.deepOrangeAccent, width: 1.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Você, João, Maria, e mais 5 curtiram isso"),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide.none,
                            left: BorderSide.none,
                            top: BorderSide.none,
                            bottom: BorderSide(
                                color: Color.fromRGBO(189, 189, 189, 0.39),
                                width: 2.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/images.png')),
                                )),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Maria - Regional de Chapecó",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text("Show de bola"),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "4 meses atrás",
                          style: TextStyle(fontSize: 10.0),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide.none,
                              left: BorderSide.none,
                              top: BorderSide.none,
                              bottom: BorderSide(
                                  color: Color.fromRGBO(189, 189, 189, 0.39),
                                  width: 2.0))),
                      child: Row(
                        children: [
                          Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('images/images.png')),
                              )),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "José - Regional de Chapecó",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "Que lugar incrível!",
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
