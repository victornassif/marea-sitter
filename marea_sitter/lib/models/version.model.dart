class Version {
  final int id;
  final String title;
  final String description;

  int numFactoryPendente;
  int numFactoryConcluido;
  int estoqueEnviado;
  int estoqueFeito;

  int get estoqueDisponivel {
    return estoqueFeito - estoqueEnviado;
  }

  int get quantidadeTotal {
    return numFactoryConcluido + numFactoryPendente;
  }

  double get percentual {
    if (numFactoryConcluido == 0) return 0;
    if (numFactoryPendente == 0) return 1;

    return (numFactoryConcluido *
        100 /
        (numFactoryPendente + numFactoryConcluido) /
        100);
  }

  Version({this.description, this.id, this.title});

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
        id: json['id'], title: json['title'], description: json['description']);
  }
}
