class Factory {
  int id;
  int tempoConclusao;
  DateTime dataCriacao;
  int quantidadeRobos;
  int versaoId;

  Factory(
      {this.id,
      this.tempoConclusao,
      this.quantidadeRobos,
      this.versaoId,
      this.dataCriacao});

  factory Factory.fromJson(Map<String, dynamic> json) {
    return Factory(
        id: json['id'],
        tempoConclusao: json['tempoConclusao'],
        dataCriacao: DateTime.parse(json['dataCriacao']),
        quantidadeRobos: json['quantidadeRobos'],
        versaoId: json['versaoId']);
  }
}
