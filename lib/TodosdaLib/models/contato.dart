

class Contato {
  int id;
  String nome;
  String mes;
  double valor;

  Contato(this.id, this.mes, this.nome, this.valor);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'mes': mes,
      'valor': valor
    };
    return map;
  }

  Contato.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    mes = map['mes'];
    valor = map['valor'];
  }
}
