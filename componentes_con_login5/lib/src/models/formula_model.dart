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
    this.authorizationDate,
    this.nameDoctor,
    this.observations,
  });

  String uid;
  String uidMed;
  String authorizationDate;
  String nameDoctor;
  String observations;

  factory FormulaModel.fromJson(Map<String, dynamic> json) => FormulaModel(
        uid: json["uid"],
        uidMed: json["uidMed"],
        authorizationDate: json["authorizationDate"],
        nameDoctor: json["nameDoctor"],
        observations: json["observations"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uidMed": uidMed,
        "authorizationDate": authorizationDate,
        "nameDoctor": nameDoctor,
        "observations": observations,
      };
}
