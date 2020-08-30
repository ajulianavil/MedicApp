// To parse this JSON data, do
//
//     final aceptadosModel = aceptadosModelFromJson(jsonString);

import 'dart:convert';

AceptadosModel aceptadosModelFromJson(String str) =>
    AceptadosModel.fromJson(json.decode(str));

String aceptadosModelToJson(AceptadosModel data) => json.encode(data.toJson());

class AceptadosModel {
  AceptadosModel({
    this.uid,
    this.applicationDate,
    this.deliveryAddress,
    this.state,
    this.toggle,
    this.uidMed,
    this.uidPac,
  });

  String uid;
  String applicationDate;
  String deliveryAddress;
  String state;
  String toggle;
  String uidMed;
  String uidPac;

  factory AceptadosModel.fromJson(Map<String, dynamic> json) => AceptadosModel(
        uid: json["uid"],
        applicationDate: json["applicationDate"],
        deliveryAddress: json["deliveryAddress"],
        state: json["state"],
        toggle: json["toggle"],
        uidMed: json["uidMed"],
        uidPac: json["uidPac"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "applicationDate": applicationDate,
        "deliveryAddress": deliveryAddress,
        "state": state,
        "toggle": toggle,
        "uidMed": uidMed,
        "uidPac": uidPac,
      };
}
