class Factory {
  int id;
  int tempoConclusao;
  final DateTime dataCriacao;
  int quantidadeRobos;
  int versaoId;

  DateTime get dataConclusao {
    return dataCriacao.add(Duration(minutes: tempoConclusao * quantidadeRobos));
  }

  double get porcentagem {
    var a = dataConclusao.difference(dataCriacao);
    var b = DateTime.now().difference(dataCriacao);

    if (b.inMinutes < 0) return 100;

    var c = b.inMinutes * 100 / a.inMinutes;

    return c > 100 ? 100 : c;
  }

  Factory({
    this.id,
    this.tempoConclusao,
    this.quantidadeRobos,
    this.versaoId,
    this.dataCriacao,
  });

  factory Factory.fromJson(Map<String, dynamic> json) {
    return Factory(
        id: json['id'],
        tempoConclusao: json['tempoConclusao'],
        dataCriacao: DateTime.parse(json['dataCriacao']),
        quantidadeRobos: json['quantidadeRobos'],
        versaoId: json['versionId']);
  }
}
