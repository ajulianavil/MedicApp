import 'package:componentes/src/models/formula_model.dart';
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
  ];

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
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(), // Only for iOS
                      // 2 items per row
                      children: events.map((title) {
                        // Loop all item in events list
                        return GestureDetector(
                          child: Card(
                              child: Column(
                                  //margin: const EdgeInsets.all(15.0),
                                  //child: getCardByTitle(title)
                                  children: <Widget>[
                                const ListTile(
                                  trailing: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage("data/meds_icon.png"),
                                  ),
                                  subtitle: Text(
                                      'Atendido el 2 de Julio de 2020. 2 medicamentos por reclamar.'),
                                  isThreeLine: true,
                                ),
                                ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: const Text('Ver detalles'),
                                      onPressed: () {/* ... */},
                                    ),
                                    FlatButton(
                                      child: const Text('Seleccionar'),
                                      onPressed: () {/* ... */},
                                    ),
                                  ],
                                ),
                              ])),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientHomePage()),
                            );
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
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
          /* Container(
            child: Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Cerrar sesión",
                  ),
                )
              ],
            ),
          ), */
        ],
      ),
    );
  }

  Widget buildformulas() {
    return FutureBuilder(
      future: _dbService.getFormula('30WkrYaIZhTtLnaf9Ry4m1EYoMH3'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //snapshot.data
          final List<Widget> myList = new List();
          for (FormulaModel item in snapshot.data) {
            myList.add(new ListTile(
              title: Text(item.nameDoctor),
            ));
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

  Column getCardByTitle(String title) {
    String img = "";

    switch (title) {
      case "Medicina General":
        img = "data/historial_formulas.svg";
        break;
      case "Dermatología":
        img = "data/update_data.svg";
        break;
      case "Nutrición":
        img = "data/sugerencias.svg";
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: Container(
            child: new Stack(
              children: <Widget>[
                SvgPicture.asset(img, width: 80.0),
              ],
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff1f5470)),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
