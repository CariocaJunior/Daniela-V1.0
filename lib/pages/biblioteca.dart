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

dataFormat(){ // DATA ATUAL
  var dtAtual = new DateTime.now().toUtc();
  var dtFormat = new DateFormat('dd/MM/yyyy - kk:mm:ss');
  String dataFormatada = dtFormat.format(dtAtual.toLocal().toUtc());
  //var formatado = dtAtual.toLocal().toString();
  return dataFormatada;
}

