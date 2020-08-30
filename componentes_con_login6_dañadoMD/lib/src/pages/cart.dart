import 'package:flutter/material.dart';
import 'meds_object.dart';

class Cart extends StatefulWidget {
  final List<Med> _cart;

  Cart(this._cart);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);

  List<Med> _cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido'),
      ),
      body: ListView.builder(
          itemCount: _cart.length,
          itemBuilder: (context, index) {
            var item = _cart[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading: Icon(
                    item.icon,
                    color: item.color,
                  ),
                  title: Text(item.name),
                  trailing: GestureDetector(
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {
                        setState(() {
                          _cart.remove(item);
                        });
                      }),
                ),
              ),
            );
          }),
    );
    return SingleChildScrollView(
      child: Column(children: <Widget>[SizedBox(height: 60.0), _crearImput()]),
    );
  }

  Widget _crearImput() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //  autofocus: true,
            //controller: email,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                hintText: 'Cra ... # ....',
                labelText: 'Dirección de envio',
                helperText: 'Escribir direccion de envio.',
                icon: Icon(Icons.location_on, color: Colors.blue)),
          ),
        );
      },
    );
  }
}
