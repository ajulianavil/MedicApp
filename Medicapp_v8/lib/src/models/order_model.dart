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
    this.applicationDate,
    this.deliveryAddress,
    this.deliveryDate,
    this.state,
  });

  String uid;
  String uidPac;
  String uidDom;
  String applicationDate;
  String deliveryAddress;
  String deliveryDate;
  String state;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        uid: json["uid"],
        uidPac: json["uidPac"],
        uidDom: json["uidDom"],
        applicationDate: json["applicationDate"],
        deliveryAddress: json["deliveryAddress"],
        deliveryDate: json["deliveryDate"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uidPac": uidPac,
        "uidDom": uidDom,
        "applicationDate": applicationDate,
        "deliveryAddress": deliveryAddress,
        "deliveryDate": deliveryDate,
        "state": state,
      };
}
