// To parse this JSON data, do
//
//     final formulaModel = formulaModelFromJson(jsonString);

import 'dart:convert';

FormulaModel formulaModelFromJson(String str) =>
    FormulaModel.fromJson(json.decode(str));

String formulaModelToJson(FormulaModel data) => json.encode(data.toJson());

class FormulaModel {
  FormulaModel({
    this.uid,
    this.uidMed,
    this.uidPac,
    this.authorizationDate,
    this.nameDoctor,
    this.observations,
    this.toggle,
  });

  String uid;
  String uidMed;
  String uidPac;
  String authorizationDate;
  String nameDoctor;
  String observations;
  bool toggle;

  factory FormulaModel.fromJson(Map<String, dynamic> json) => FormulaModel(
        uid: json["uid"],
        uidMed: json["uidMed"],
        uidPac: json["uidPac"],
        authorizationDate: json["authorizationDate"],
        nameDoctor: json["nameDoctor"],
        observations: json["observations"],
        toggle: json["toggle"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uidMed": uidMed,
        "uidPac": uidPac,
        "authorizationDate": authorizationDate,
        "nameDoctor": nameDoctor,
        "observations": observations,
        "toggle": toggle,
      };
}
