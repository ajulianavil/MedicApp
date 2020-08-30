import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:componentes/src/models/formula_model.dart';
import 'package:componentes/src/models/order_model.dart';
import 'package:componentes/src/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class MedsRequestPage extends StatefulWidget {
  @override
  _MedsRequestPageState createState() => _MedsRequestPageState();
}

class _MedsRequestPageState extends State<MedsRequestPage> {
  List<FormulaModel> addedformulas = new List();
  List<OrderModel> addedOrders = new List();
  final firestoreInstance = Firestore.instance;
  String _uid;
  String _date = '';

  DataBaseService _dbService = new DataBaseService();

  final TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_uid == null) _uid = ModalRoute.of(context).settings.arguments;
    // Create empty app with backgroud
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar formulas'),
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
                              'Fórmulas pendientes',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Seleccione las formulas que desea pedir',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
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
                        SizedBox(height: 5.0),
                        _crearImput(),
                        SizedBox(height: 5.0),
                        _crearFecha(context),
                        SizedBox(height: 0.0),
                        _crearBoton(),
                        SizedBox(height: 5.0),
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

/*   Widget _crearImput() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //  autofocus: true,
            controller: emailController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                hintText: 'cll 16 # 29-46',
                labelText: 'Dirección de entrega',
                helperText: 'donde desea recibir sus medicamentos',
                icon: Icon(Icons.store_mall_directory, color: Colors.blue)),
          ),
        );
      },
    );
  } */

  Widget _crearImput() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
              //  autofocus: true,
              controller: emailController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  hintText: 'cll 16 # 29-46',
                  labelText: 'Dirección de entrega',
                  helperText: 'donde desea recibir sus medicamentos',
                  icon: Icon(Icons.store_mall_directory, color: Colors.blue)),
              onChanged: (valor) => setState(() {})),
        );
      },
    );
  }

  Widget _crearBoton() {
    return FutureBuilder(
      future: _dbService.getFormula(_uid),
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
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Text('Solicitar medicamentos'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () async {
            for (FormulaModel item1 in snapshot.data) {
              if (item1.toggle == false) {
                print(item1.toggle);
                firestoreInstance.collection("pedidos").add({
                  "uidPac": item1.uidPac,
                  "uidMed": item1.uidMed,
                  "applicationDate": _date,
                  "deliveryAddress": emailController.text.trim(),
                  "state": 'en revision',
                }).then((value) {
                  print(value.documentID);
                });
                //final response = await _dbService.putOrder(
                // _order);
                //print(response);
              }
              /* if (item1.toggle == false) {
                await Firestore.instance
                    .runTransaction((Transaction myTransaction) async {
                  await myTransaction
                      .delete(snapshot.data.documents[item1].reference);
                });
              } */
            }
            print(_uid);
            Navigator.pushNamed(context, 'cart', arguments: _uid);
          },
        );
      },
    );
  }

  _crearFecha(BuildContext context) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                )
              ]),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Fecha de pedido'),
              Icon(Icons.calendar_today, color: Colors.blue),
              Text(_date),
            ],
          )),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime(2025),
      //locale: Locale('es', 'Es')
    );

    if (picked != null) {
      setState(() {
        final a = picked.toString().split(' ');
        _date = a[0];
        print(_date);
      });
    }
  }

  Widget buildformulas() {
    return FutureBuilder(
      future: _dbService.getFormula(_uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //snapshot.data
          final List<Widget> myList = new List();
          for (FormulaModel item in snapshot.data) {
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
                            'Atendido por: ${item.nameDoctor}\nAutorización: ${item.authorizationDate}\nObserv: ${item.observations}'),
                        isThreeLine: true,
                        trailing: GestureDetector(
                          child: item.toggle
                              ? Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                          onTap: () async {
                            _dbService.setFormula(item);
                            if (item.toggle == true) {
                              addedformulas.remove(item);
                            } else {
                              addedformulas.add(item);
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
