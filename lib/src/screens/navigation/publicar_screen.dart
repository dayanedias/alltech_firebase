import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class PublicarScreen extends StatefulWidget {
  @override
  _PublicarScreenState createState() => _PublicarScreenState();
}

class _PublicarScreenState extends State<PublicarScreen> {
  String _nome = '';
  String _atividade = '';
  String _descricao = '';
  //List<TipoAtividade> _atividadeSelecionada = [];

  FocusNode _focusNode = new FocusNode();

  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNome() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nome'),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Digite um nome';
        }
      },
      onSaved: (String value) {
        _nome = value;
      },
    );
  }

  Widget _buildAtividade() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Atividade'),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Digite uma atividade';
        }
      },
      onSaved: (String value) {
        _atividade = value;
      },
    );
  }

  Widget _buildDescricao() {
    return TextFormField(
      focusNode: _focusNode,
      onTap: _requestFocus,
      cursorColor: Colors.deepOrangeAccent,
      decoration: InputDecoration(
        labelText: _focusNode.hasFocus ? '' : 'Descreva sua atividade',
        labelStyle: TextStyle(
            color: _focusNode.hasFocus ? Colors.deepOrangeAccent : Colors.grey),
        fillColor: Colors.deepOrangeAccent,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrangeAccent),
        ),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.multiline,
      minLines: 5,
      maxLines: 10,
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Digite uma descrição';
        }
      },
      onSaved: (String value) {
        _descricao = value;
      },
    );
  }

  // Widget _buildMultiSelectField() {
  //   return MultiSelectDialogField(
  //     items: atividades.map((e) => MultiSelectItem(e, e.nome)).toList(),
  //     title: Text("Selecione as atividades"),
  //     buttonText: Text("Selecione as atividades"),
  //     listType: MultiSelectListType.LIST,
  //     selectedColor: Colors.deepOrangeAccent,
  //     onConfirm: (values) => {
  //       setState(() {
  //         _atividadeSelecionada = values;
  //       })
  //     },
  //     // ignore: missing_return
  //     validator: (List value) {
  //       if (value.isEmpty) {
  //         return 'Selecione uma atividade';
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    //final tipoAtividadeP = Provider.of<TipoAtividadeProvider>(context);

    //print(tipoAtividadeP.tipoAtividade);

    return Scaffold(
      appBar: AppBar(
        title: Text("Nova publicação"),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check_circle_outline),
              onPressed: () => {
                if (!_formKey.currentState.validate()) {'Error'},
                _formKey.currentState.save()
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children: [
                // if (imagem != null)
                //   SizedBox(
                //     height: 200.0,
                //     child: Image.file(File(imagem.path)),
                //   ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //_buildNome(),
                      //_buildAtividade(),
                      SizedBox(
                        height: 10,
                      ),
                      // MultiSelectDialogField(
                      //   items: tipoAtividadeP.tipoAtividade
                      //       .map((e) => MultiSelectItem(e, e.descricao_atividade))
                      //       .toList(),
                      //   title: Text("Selecione as atividades"),
                      //   buttonText: Text("Selecione as atividades"),
                      //   listType: MultiSelectListType.LIST,
                      //   selectedColor: Colors.deepOrangeAccent,
                      //   onConfirm: (values) => {
                      //     setState(() {
                      //       _atividadeSelecionada = values;
                      //     })
                      //   },
                      //   // ignore: missing_return
                      //   validator: (List value) {
                      //     if (value.isEmpty) {
                      //       return 'Selecione uma atividade';
                      //     }
                      //   },
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      _buildDescricao(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.photo_camera_outlined),
                        onPressed: () => { }),
                    IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.folder_open),
                        onPressed: () => { }),
                    IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.add_location_alt_outlined),
                        onPressed: () => {}),
                    IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.attach_file),
                        onPressed: () => {}),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     RaisedButton(
                //         child: (Text("Cancelar")),
                //         onPressed: () { }),
                //     SizedBox(width: 180.0,),
                //
                //     RaisedButton(
                //         child: (Text("Enviar")),
                //         onPressed: () { })
                //   ],
                // ),
              ],
            )),
      ),
    );
  }

  final atividadesSelecionada = TextEditingController();
//
//   static List<Atividades> atividades = [
//     Atividades(id: 1, nome: "Atividade 1"),
//     Atividades(id: 2, nome: "Atividade 2"),
//     Atividades(id: 3, nome: "Atividade 3"),
//     Atividades(id: 4, nome: "Atividade 4"),
//     Atividades(id: 5, nome: "Atividade 5"),
//     Atividades(id: 6, nome: "Atividade 6"),
//     Atividades(id: 7, nome: "Atividade 7"),
//     Atividades(id: 8, nome: "Atividade 8"),
//   ];
}
//
// class Atividades {
//   final int id;
//   final String nome;
//
//   Atividades({this.id, this.nome});
// }
