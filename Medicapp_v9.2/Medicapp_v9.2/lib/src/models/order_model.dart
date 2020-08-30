// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.uid,
    this.uidPac,
    this.uidDom,
    this.uidMed,
    this.applicationDate,
    this.deliveryAddress,
    this.state,
  });

  String uid;
  String uidPac;
  String uidDom;
  String uidMed;
  String applicationDate;
  String deliveryAddress;
  String state;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        uid: json["uid"],
        uidPac: json["uidPac"],
        uidDom: json["uidDom"],
        uidMed: json["uidMed"],
        applicationDate: json["applicationDate"],
        deliveryAddress: json["deliveryAddress"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uidPac": uidPac,
        "uidDom": uidDom,
        "uidMed": uidMed,
        "applicationDate": applicationDate,
        "deliveryAddress": deliveryAddress,
        "state": state,
      };
}
