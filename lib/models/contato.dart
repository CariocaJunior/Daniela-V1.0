
class Contato {
  String id;
  String nome;
  String HT;
  double LE;
  double VL;
  int ES;
  double TECQTD;
  double TECCUS;
  double ELAQTD;
  double ELACUS;
  String DT;

  Contato(this.id, this.nome, this.HT, this.LE, this.VL, this.ES, this.TECQTD,
      this.TECCUS, this.ELAQTD, this.ELACUS, this.DT);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'HT': HT,
      'LE': LE,
      'VL': VL,
      'ES': ES,
      'TECQTD': TECQTD,
      'TECCUS': TECCUS,
      'ELAQTD': ELAQTD,
      'ELACUS': ELACUS,
      'DT': DT
    };
    return map;
  }

  Contato.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    HT = map['HT'];
    LE = map['LE'];
    VL = map['VL'];
    ES = map['ES'];
    TECQTD = map['TECQTD'];
    TECCUS = map['TECCUS'];
    ELAQTD = map['ELAQTD'];
    ELACUS = map['ELACUS'];
    DT = map['DT'];
  }
}
