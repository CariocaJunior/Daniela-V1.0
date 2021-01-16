import 'dart:ffi';

class Contato{
  int id;
  String mes;
  double caixa;
  double markup;
  double TotVendas;
  double Producao;


  Contato(this.id, this.mes,this.caixa, this.markup, this.TotVendas, this.Producao);

  Map<String,dynamic> toMap () {

    var map = <String,dynamic> {
      'id': id,
      'mes': mes,
      'caixa': caixa,
      'markup': markup,
      'TotVendas': TotVendas,
      'Producao': Producao,
    };
    return map;
  }

  Contato.fromMap(Map<String,dynamic> map){
    id = map['id'];
    mes = map['mes'];
    caixa = map['caixa'];
    markup = map['markup'];
    TotVendas = map['TotVendas'];
    Producao = map['Producao'];
  }
}