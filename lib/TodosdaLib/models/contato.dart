class Contato {
  String id;
  String nome;
  String mes;
  double valor;
  String mesFiltro;

  Contato(this.id, this.mes, this.nome, this.valor, this.mesFiltro);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'mes': mes,
      'valor': valor,
      'mesFiltro': mesFiltro
    };
    return map;
  }

  Contato.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    mes = map['mes'];
    valor = map['valor'];
    mesFiltro = map['mesFiltro'];
  }
}
