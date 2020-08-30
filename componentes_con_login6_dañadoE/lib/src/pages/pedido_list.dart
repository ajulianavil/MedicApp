import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:componentes/src/models/order_model.dart';
import 'package:componentes/src/services/database_service.dart';
import 'package:flutter/material.dart';

class PedidoList extends StatefulWidget {
  final OrderModel item;
  PedidoList({this.item});

  @override
  _PedidoListState createState() => _PedidoListState();
}

class _PedidoListState extends State<PedidoList> {
  DataBaseService _dbService = new DataBaseService();
  bool pacienteFlag = false;
  var paciente;

  @override
  Widget build(BuildContext context) {
    _dbService.getPatientbyUID(widget.item.uidPac).then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        pacienteFlag = true;
        paciente = docs.documents[0].data;
      } else {
        print('Un error ha ocurrido');
      }
    });

    return Card(
        elevation: 5.0,
        child: Column(children: <Widget>[
          ListTile(
            trailing: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("data/cart.png"),
            ),
            title: Text('Pedidos'),
            subtitle: Text(pacienteFlag
                ? '\nFECHA SOLICITUD: ${widget.item.applicationDate}\nFECHA ENTREGA: ${widget.item.deliveryAddress}\nESTADO: ${widget.item.state}\nPACIENTE: ${paciente['name']} ${paciente['lastName']}'
                : 'Error inesperado'),
            isThreeLine: true,
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('Ver detalles'),
                onPressed: () {/* ... */},
              ),
              FlatButton(
                child: const Text('Aprobar'),
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ]));
  }
}
