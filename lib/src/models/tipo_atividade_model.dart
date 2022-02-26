class TipoAtividade{
  String descricao;
  int pontos;
  DateTime data_inicio;
  DateTime data_fim;


  TipoAtividade({ this.descricao, this.pontos });


  Map<String, dynamic> toMap(){
    return {
      'descricao': descricao,
      'pontos': pontos,
      'data_inicio': DateTime.now(),
    };
  }

}