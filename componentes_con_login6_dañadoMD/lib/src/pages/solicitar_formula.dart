import 'package:componentes/src/models/formula_model.dart';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'meds_object.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:componentes/src/services/database_service.dart';

void main() => runApp(FormulaRequestPage());

class FormulaRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Solicitar Medicamentos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String _uid;

DataBaseService _dbService = new DataBaseService();
final TextEditingController uidMedController = new TextEditingController();
final TextEditingController authorizationDateController =
    new TextEditingController();
final TextEditingController nameDoctorController = new TextEditingController();
final TextEditingController observationsController =
    new TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  List<Med> _cartList = List<Med>();

  @override
  void initState() {
    super.initState();
    // _populateMeds();
  }

  @override
  Widget build(BuildContext context) {
    if (_uid == null) _uid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 36.0,
                  ),
                  if (_cartList.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _cartList.length.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                if (_cartList.isNotEmpty)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(_cartList),
                    ),
                  );
              },
            ),
          )
        ],
      ),
      body: // _buildGridView(),
          Stack(
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
                  Expanded(child: buildformulas()), //_buildGridView
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
                  elevation: 4.0,
                  child: Column(children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.local_pharmacy, size: 50),
                      title: Text('Formula médica'),
                      subtitle: Text(
                          '\nATENDIDO POR: ${item.nameDoctor}\nFECHA AUTORI: ${item.authorizationDate}\nOBSERVACIONES: ${item.observations}\nMedicamentos:${item.uidMed}'),
                      isThreeLine: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                        bottom: 8.0,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          child: (!_cartList.contains(item))
                              ? Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                          onTap: () {
                            setState(() {
                              if (!_cartList.contains(item))
                                _cartList.add(Med(
                                  name: Text(item.uidMed).data,
                                  icon: Icons.local_pharmacy,
                                  color: Colors.green,
                                ));
                              else
                                _cartList.remove(item);
                            });
                          },
                        ),
                      ),
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
