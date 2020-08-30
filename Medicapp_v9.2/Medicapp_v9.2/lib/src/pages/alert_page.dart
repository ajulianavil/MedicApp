import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page'),
      ),
      body: Column(
        children: <Widget>[
          SvgPicture.asset("data/logo.svg", width: 70.0),
          Container(
            height: 150,
            width: 380,
            decoration: BoxDecoration(color: Colors.red),
            child: Text(
              "Menu",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 45),
            ),
          ),
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
