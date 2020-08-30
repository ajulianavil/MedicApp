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
    this.description,
    this.nameMedicine,
    this.quantity,
    this.uidForm,
  });

  String uid;
  String description;
  String nameMedicine;
  String quantity;
  String uidForm;

  factory FormulaModel.fromJson(Map<String, dynamic> json) => FormulaModel(
        uid: json["uid"],
        description: json["description"],
        nameMedicine: json["nameMedicine"],
        quantity: json["quantity"],
        uidForm: json["uidForm"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "description": description,
        "nameMedicine": nameMedicine,
        "quantity": quantity,
        "uidForm": uidForm,
      };
}
