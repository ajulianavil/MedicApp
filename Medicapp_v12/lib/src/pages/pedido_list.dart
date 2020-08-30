import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:componentes/src/models/order_model.dart';
import 'package:componentes/src/models/pedidos_aceptados_model.dart';
import 'package:componentes/src/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class PedidoAceptado extends StatefulWidget {
  final OrderModel item;
  final String uidPaciente;
  PedidoAceptado({this.item, this.uidPaciente});
  @override
  _PedidoAceptadoState createState() => _PedidoAceptadoState();
}

class _PedidoAceptadoState extends State<PedidoAceptado> {
  String _uid;
  String full = '';
  bool pacienteFlag = false;
  var paciente;

  DataBaseService _dbService = new DataBaseService();

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
        title: Text('Pedidos Aceptados'),
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
                              'Próximos a despachar: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: buildformulas(),
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
            child: Text('Volver al inicio'),
          ),
          padding: const EdgeInsets.all(3.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 0.0,
          color: Colors.blue[500],
          textColor: Colors.white,
          onPressed: () async {
            Navigator.pushNamed(context, '/');
          },
        );
      },
    );
  }

  Widget buildformulas() {
    return FutureBuilder(
      future: _dbService.getPedidosAceptados(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final List<Widget> myList = new List();
          //snapshot.data

          for (AceptadosModel item in snapshot.data) {
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
                          backgroundImage: AssetImage("data/meds_icon.png"),
                        ),
                        title: MedicineNameText(uidMedicine: item.uidMed),
                        subtitle: Text(
                            'Resumen de pedido\nEstado: ${item.state}\nDirección Entrega: ${item.deliveryAddress}\nPaciente: ${paciente['name']} ${paciente['lastName']}'),
                        isThreeLine: true,
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
