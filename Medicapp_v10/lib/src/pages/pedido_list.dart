import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:componentes/src/models/formula_model.dart';
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
  var medicamento;
  bool medicamentoFlag = false;

  @override
  void initState() {
    _dbService.getPatientbyUID(widget.item.uidPac).then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        setState(() => pacienteFlag = true);
        setState(() => paciente = docs.documents[0].data);
      } else {
        print('Un error ha ocurrido');
      }
    });

    _dbService
        .getMedicamentobyUID(widget.item.uidMed)
        .then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        setState(() => medicamentoFlag = true);
        setState(() => medicamento = docs.documents[0].data);
      } else {
        print('Un error ha ocurrido');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        child: Column(children: <Widget>[
          ListTile(
            trailing: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("data/cart.png"),
            ),
            title: Text('Pedidos'),
            subtitle: Text((pacienteFlag == true || medicamentoFlag == true)
                ? '\nFecha solicitud: ${widget.item.applicationDate}\nDirección entrega: ${widget.item.deliveryAddress}\nEstado: ${widget.item.state}\nPaciente: ${paciente['name']} ${paciente['lastName']}\nMedicamento: ${medicamento['nameMedicine']}'
                : ''),
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
