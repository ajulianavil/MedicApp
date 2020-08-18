import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:componentes/src/pages/solicitar_meds_paciente.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_page.dart';

class PatientHomePage extends StatelessWidget {
  List<String> events = [
    "Historial de fórmulas",
    "Actualizar datos",
    "Sugerencias",
    "Contáctenos",
    "Historial de fórmulas",
    "Actualizar datos",
    "Sugerencias",
    "Contáctenos"
  ];

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
                        SvgPicture.asset('data/profile.svg', height: 65.0),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Hola Paciente',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Calle 9 # 27 -52',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView(
                      physics: BouncingScrollPhysics(), // Only for iOS
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2), // 2 items per row
                      children: events.map((title) {
                        // Loop all item in events list
                        return GestureDetector(
                            child: Card(
                              margin: const EdgeInsets.all(15.0),
                              child: getCardByTitle(title),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedsRequestPage()),
                              );
                              // Show Toast
                              //Fluttertoast.showToast(
                              //   msg: "Clic en " + title,
                              //   toastLength: Toast.LENGTH_SHORT,
                              //   gravity: ToastGravity.CENTER,
                              //   backgroundColor: Colors.red,
                              //   textColor: Colors.white,
                              //   fontSize: 16.0);
                            });
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
}

Column getCardByTitle(String title) {
  String img = "";

  switch (title) {
    case "Historial de fórmulas":
      img = "data/historial_formulas.svg";
      break;
    case "Actualizar datos":
      img = "data/update_data.svg";
      break;
    case "Sugerencias":
      img = "data/sugerencias.svg";
      break;
    case "Contáctenos":
      img = "data/contactos.svg";
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
