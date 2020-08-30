import 'package:componentes/src/models/order_model.dart';
import 'package:componentes/src/models/user_model.dart';
import 'package:componentes/src/pages/pedido_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:componentes/src/services/database_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_page.dart';

class ReviewOrderPage extends StatefulWidget {
  @override
  _ReviewOrderPageState createState() => _ReviewOrderPageState();
}

class _ReviewOrderPageState extends State<ReviewOrderPage> {
  List<String> events = [
    "Medicina General",
    "Dermatología",
    "Nutrición",
  ];
  UserModel _user;
  String _uid;
  DataBaseService _dbService = new DataBaseService();
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
                              'Revisión de pedidos ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '3 pedidos pendientes por validación',
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
        ],
      ),
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
            myList.add(PedidoList(item: item));
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
