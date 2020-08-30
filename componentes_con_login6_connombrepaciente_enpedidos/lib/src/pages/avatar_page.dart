import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://imagenes.20minutos.es/files/image_656_370/uploads/imagenes/2020/06/23/el-delfin-robot-pesa-unos-270-kilos-y-tiene-una-duracion-de-bateria-de-unas-10-horas.jpeg'),
              radius: 25.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('SL'),
              backgroundColor: Colors.pink,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.keyboard_return),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
