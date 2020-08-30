import 'package:componentes/src/models/formula_model.dart';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'meds_object.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:componentes/src/services/database_service.dart';

void main() => runApp(FormulaRequestPage());



class FormulaRequestPage extends StatefulWidget {

  @override
  _FormulaRequestPageState createState() => _FormulaRequestPageState();
}

String _uid;

  DataBaseService _dbService = new DataBaseService();
  final TextEditingController uidMedController = new TextEditingController();
  final TextEditingController authorizationDateController =
      new TextEditingController();
  final TextEditingController nameDoctorController =
      new TextEditingController();
  final TextEditingController observationsController =
      new TextEditingController();


class _FormulaRequestPageState extends State<FormulaRequestPage> {
  List<Med> _dishes = List<Med>();

  List<Med> _cartList = List<Med>();

  @override
  void initState() {
    super.initState();
    _populateMeds();
  }

  @override
  Widget build(BuildContext context) {
    if (_uid == null) _uid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar formulas'),
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
      body:// _buildGridView(),
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
                  Expanded(child: _buildListView() ), //_buildGridView
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

ListView _buildListView() {
    return ListView.builder(
      itemCount: _dishes.length,
      itemBuilder: (context, index) {
        var item = _dishes[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 2.0,
          ),
          child: Card(
            elevation: 4.0,
            child: ListTile(
              leading: Icon(
                item.icon,
                color: item.color,
              ),
              title: Text(item.name),
              trailing: GestureDetector(
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
                      _cartList.add(item);
                    else
                      _cartList.remove(item);
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _populateMeds() {
    var list = <Med>[
      Med(
        name: 'Medicamentos: Acetaminofem 500mg. \nAtendido por: Gabriel Torres. \nFecha Autorización: 14/08/2020 \nObservaciones: Tomar 2 pastillas cada 24 horas',
        icon: Icons.local_pharmacy,
        color: Colors.amber,
      ),
      Med(
        name: 'Medicamentos: Amoxicilina 500mg. \nAtendido por: Santiago Riveros. \nFecha Autorización: 20/11/2020 \nObservaciones: Tomar cada 12 horas',
        icon: Icons.local_pharmacy,
        color: Colors.deepOrange,
      ),
      Med(
        name: 'Medicamentos: Diclofenaco 200mg. \nAtendido por: Juan Guerra. \nFecha Autorización: 13/08/2020 \nObservaciones: Tomar 2 tabletas cada 24 horas',
        icon: Icons.local_pharmacy,
        color: Colors.brown,
      ),
     
    ];

    setState(() {
      _dishes = list;
    });
  }
  

  Widget buildformulas() {
    return FutureBuilder(
      future: _dbService.getFormula(_uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var list=<Med>[];
        if (snapshot.hasData) {
          
        
          //snapshot.data
          for (FormulaModel item in snapshot.data) {
            var med = Med(
                      name: Text('\nMedicamentos:${item.uidMed} \nATENDIDO POR: ${item.nameDoctor}\nFECHA AUTORI: ${item.authorizationDate}\nOBSERVACIONES: ${item.observations}').data,
                      icon: Icons.local_pharmacy,
                      color: Colors.green,
                    );
            list.add(
            
              med
      
            );
         } return Container();

        } else {
          return Container();
        }
        

  }     
    );
  }  
}