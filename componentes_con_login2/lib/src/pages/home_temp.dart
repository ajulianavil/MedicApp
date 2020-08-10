import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  final opciones = ['uno', 'dos', 'tres'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes Temp'),
      ),
      body: ListView(children: _crearItems()),
    );
  }

  List<Widget> _crearItems() {
    List<Widget> lista = new List<Widget>();

    for (var opt in opciones) {
      final tempWidget = ListTile(
        title: Text(opt),
        subtitle: Text('Cualquier cosa'),
        leading: Icon(Icons.account_balance),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {},
      );

      lista..add(tempWidget)..add(Divider());
    }
    return lista;
  }
}
