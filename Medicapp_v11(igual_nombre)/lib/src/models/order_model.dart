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
    this.uidMed,
    this.applicationDate,
    this.deliveryAddress,
    this.state,
    this.toggle,
  });

  String uid;
  String uidPac;
  String uidMed;
  String applicationDate;
  String deliveryAddress;
  String state;
  bool toggle;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        uid: json["uid"],
        uidPac: json["uidPac"],
        uidMed: json["uidMed"],
        applicationDate: json["applicationDate"],
        deliveryAddress: json["deliveryAddress"],
        state: json["state"],
        toggle: json["toggle"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uidPac": uidPac,
        "uidMed": uidMed,
        "applicationDate": applicationDate,
        "deliveryAddress": deliveryAddress,
        "state": state,
        "toggle": toggle,
      };
}
