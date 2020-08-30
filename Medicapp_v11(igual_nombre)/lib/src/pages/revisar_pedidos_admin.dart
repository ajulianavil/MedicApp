import 'package:componentes/src/models/order_model.dart';
import 'package:componentes/src/models/user_model.dart';
import 'package:componentes/src/pages/pedido_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:componentes/src/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewOrderPage extends StatefulWidget {
  final OrderModel item;
  final String uidPaciente;
  ReviewOrderPage({this.uidPaciente, this.item});

  @override
  _ReviewOrderPageState createState() => _ReviewOrderPageState();
}

class _ReviewOrderPageState extends State<ReviewOrderPage> {
  final firestoreInstance = Firestore.instance;
  List<OrderModel> addedpedidos = new List();
  String _uid;
  DataBaseService _dbService = new DataBaseService();

  bool pacienteFlag = false;
  var paciente;

  @override
  void initState() {
    print(widget.uidPaciente);
    _dbService.getPatientbyUID(widget.uidPaciente).then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        setState(() => pacienteFlag = true);
        setState(() => paciente = docs.documents[0].data);
      } else {
        print('Un error ha ocurrido');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_uid == null) _uid = ModalRoute.of(context).settings.arguments;

    // Create empty app with backgroud
    return Scaffold(
      appBar: AppBar(
        title: Text('Aceptar Pedidos'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xff1a8bc8), Color(0xffa55cd4)],
            stops: [0.4, 1],
          )),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffa55cd4), Color(0xff1a8bc8)],
                  stops: [0.0, 0.5],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 45.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Revisión de pedidos',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Seleccione los pedidos que desea aceptar',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: buildPedidos(),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 3.0),
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 3.0,
                              offset: Offset(0.0, 5.0),
                              spreadRadius: 3.0)
                        ]),
                    child: Column(
                      children: <Widget>[
                        //Text('Ingreso', style: TextStyle(fontSize: 20.0)),

                        _crearBoton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearBoton() {
    return FutureBuilder(
      future: _dbService.getOrder(_uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xff1a8bc8), Color(0xffa55cd4)],
              stops: [0.4, 1],
            )),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
            child: Text('Aceptar pedidos'),
          ),
          padding: const EdgeInsets.all(3.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 0.0,
          color: Colors.blue[500],
          textColor: Colors.white,
          onPressed: () async {
            for (OrderModel item1 in snapshot.data) {
              if (item1.toggle == false) {
                print(item1.toggle);
                firestoreInstance.collection("pedidos_accept").add({
                  "uidPac": item1.uidPac,
                  "uidMed": item1.uidMed,
                  "state": "Aceptado",
                  "applicationDate": item1.applicationDate,
                  "deliveryAddress": item1.deliveryAddress,
                  "toggle": item1.toggle
                }).then((value) {
                  print(value.documentID);
                });
              }
            }
            print(_uid);
            Navigator.pushNamed(context, 'pedidosaceptados', arguments: _uid);
          },
        );
      },
    );
  }

  Widget buildPedidos() {
    return FutureBuilder(
      future: _dbService.getOrder(_uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //snapshot.data
          final List<Widget> myList = new List();
          for (OrderModel item in snapshot.data) {
            myList.add(
              Card(
                elevation: 5.0,
                margin: EdgeInsets.all(6.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("data/cart.png"),
                        ),
                        title: MedicineNameText(uidMedicine: item.uidMed),
                        subtitle: Text(pacienteFlag
                            ? 'Fecha solicitud: ${item.applicationDate}\nDirección entrega: ${item.deliveryAddress}\nEstado: ${item.state}\nPaciente: ${item.uidPac}\nPaciente: ${paciente['name']} ${paciente['lastName']}'
                            : ''),
                        isThreeLine: true,
                        trailing: GestureDetector(
                          child: item.toggle
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                          onTap: () async {
                            _dbService.setOrder(item);
                            if (item.toggle == true) {
                              addedpedidos.remove(item);
                            } else {
                              addedpedidos.add(item);
                            }
                            setState(() => this);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView(
            children: myList,
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class MedicineNameText extends StatefulWidget {
  final String uidMedicine;
  const MedicineNameText({
    Key key,
    @required this.uidMedicine,
  }) : super(key: key);

  @override
  _MedicineNameTextState createState() => _MedicineNameTextState();
}

class _MedicineNameTextState extends State<MedicineNameText> {
  DataBaseService _dbService = new DataBaseService();
  bool medicamentoFlag = false;
  var medicamento;

  @override
  void initState() {
    print(widget.uidMedicine);
    _dbService
        .getMedicamentobyUID(widget.uidMedicine)
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
    return Text(
        medicamentoFlag ? 'Medicina: ${medicamento['nameMedicine']}' : '');
  }
}

class PacienteNameText extends StatefulWidget {
  final String uidPaciente;
  const PacienteNameText({
    Key key,
    @required this.uidPaciente,
  }) : super(key: key);

  @override
  _PacienteNameTextState createState() => _PacienteNameTextState();
}

class _PacienteNameTextState extends State<PacienteNameText> {
  DataBaseService _dbService = new DataBaseService();
  bool pacienteFlag = false;
  var paciente;

  @override
  void initState() {
    print(widget.uidPaciente);
    _dbService.getPatientbyUID(widget.uidPaciente).then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        setState(() => pacienteFlag = true);
        setState(() => paciente = docs.documents[0].data);
      } else {
        print('Un error ha ocurrido');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(pacienteFlag
        ? 'Paciente: ${paciente['name']} ${paciente['lastName']}'
        : '');
  }
}
