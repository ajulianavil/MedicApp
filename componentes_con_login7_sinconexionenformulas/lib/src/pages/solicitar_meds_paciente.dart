import 'package:componentes/src/models/formula_model.dart';
import 'package:componentes/src/models/user_model.dart';
import 'package:componentes/src/pages/patient_main_page.dart';
import 'package:componentes/src/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_page.dart';

class MedsRequestPage extends StatefulWidget {
  @override
  _MedsRequestPageState createState() => _MedsRequestPageState();
}

class _MedsRequestPageState extends State<MedsRequestPage> {
  final List<String> events = [
    "Medicina General",
    "Dermatología",
    "Nutrición",
    "Oftagmologia",
  ];

  String _uid;

  DataBaseService _dbService = new DataBaseService();
  final TextEditingController uidMedController = new TextEditingController();
  final TextEditingController authorizationDateController =
      new TextEditingController();
  final TextEditingController nameDoctorController =
      new TextEditingController();
  final TextEditingController observationsController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_uid == null) _uid = ModalRoute.of(context).settings.arguments;
    // Create empty app with backgroud
    return Scaffold(
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
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 75.0),
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
                              '2 fórmulas activas/ 1 caducada',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(child: buildformulas()),
                  Container(
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Regresar",
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            "Cerrar sesión",
                          ),
                        )
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
                  child: Column(children: <Widget>[
                    ListTile(
                      trailing: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("data/meds_icon.png"),
                      ),
                      title: Text('Formula médica'),
                      subtitle: Text(
                          '\nATENDIDO POR: ${item.nameDoctor}\nFECHA AUTORI: ${item.authorizationDate}\nOBSERVACIONES: ${item.observations}'),
                      isThreeLine: true,
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('Ver detalles'),
                          onPressed: () {/* ... */},
                        ),
                        FlatButton(
                          child: const Text('Solicitar'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ])),
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
