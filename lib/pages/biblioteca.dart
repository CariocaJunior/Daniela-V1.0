library danielaGlobal;
import 'package:daniela/models/contato.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:daniela/contato.dart' as d2;
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// VARIÁVEL DE CONTROLE (EDITAR/ADICIONAR PRODUTO)
bool varLibrary = true;
bool editarLibrary = false;

// VARIÁVEIS QUE RECEBERÃO OS DADOS DO FIREBASE
var dataLibrary      ;
var elastCustLibrary ;
var elastQTDLibrary  ;
var estLibrary       ;
var horaTrabLibrary  ;
var lucroEstLibrary  ;
var tecCustLibrary   ;
var tecQTDLibrary    ;
var valorLiqLibrary  ;
var nomeLibrary      ;
var idLibrary        ;

// DELETA O DOCUMENTO DO FIREBASE
void deletar(indice) {
  FirebaseFirestore.instance
      .collection("pedido")
      .where("id", isEqualTo : indice)
      .get().then((value){
    value.docs.forEach((element) {
      FirebaseFirestore.instance.collection("pedido").doc(element.id).delete().then((value){
      });
    });
  });
}

void criar(elacus, elaqtd, es, ht, le, teccus, tecqtd, vl) {

  if(elacus != null){elacus = elacus;} else{elacus = elastCustLibrary;}
  if(elaqtd != null){} else{elaqtd = elastQTDLibrary;}
  if(es != null)    {} else{es = estLibrary;}
  if(ht != null)    {} else{ht = horaTrabLibrary;}
  if(le != null)    {} else{le = lucroEstLibrary;}
  if(teccus != null){} else{teccus = tecCustLibrary;}
  if(tecqtd != null){} else{tecqtd = tecQTDLibrary;}
  if(vl != null)    {} else{vl = valorLiqLibrary;}

  Future.delayed(const Duration(microseconds: 500), () {
    FirebaseFirestore.instance.collection("pedido").doc(nomeLibrary).set({
      'DT' : dataFormat(),
      'ELACUS': elacus,
      'ELAQTD': elaqtd,
      'ES': es,
      'HT': ht,
      'LE': le,
      'TECCUS': teccus,
      'TECQTD': tecqtd,
      'VL': vl,
      'id': idLibrary,
      'nome': nomeLibrary
    });
  });
}

void atualizar(indice){
  FirebaseFirestore.instance
      .collection('pedido')
      .where("id", isEqualTo : indice)
      .get().then((value){
    value.docs.forEach((element){
      FirebaseFirestore.instance.collection("pedido").doc(indice).update({
        'ELACUS': 8.98,
        'ELAQTD': 7.58,
        'ELAQTD': 8,
        'ES': 8,
        'HT': '51:22:69',
        'LE': 10,
        'TECCUS': 10,
        'TECQTD': 10,
        'VL': 10,
        'id': idLibrary ,
        'nome': nomeLibrary
      });
    });
  });
  //return _exibeContatoPage();
}

// Future<void> addUser() {
//   return users.add({
//     'full_name' : fullName,
//     'Company': company,
//     'age': age
//   })
// }

conditionalName(bool variable){
  if(variable == true){
    return 'Novo produto';
  }
  else{
    return 'Editar produto';
  }
}

idRandom(){ // ID RANDÔMICO
  var uuid = Uuid();
  return uuid.v4();
}

external DateTime subtract(Duration duration);
dataFormat(){ // DATA ATUAL
  var dtAtual = new DateTime.now();
  var dtFormat = new DateFormat('dd/MM/yyyy - kk:mm:ss');
  String dataFormatada = dtFormat.format(dtAtual.toLocal());
  print(DateTime.now());
  return dataFormatada;
}

