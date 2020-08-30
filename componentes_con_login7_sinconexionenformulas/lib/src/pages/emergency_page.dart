import 'package:componentes/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IconHeaderMenu(
            icon: FontAwesomeIcons.plus,
            titulo: 'Fórmulas Medicas',
            color2: Color(0xff67ACF2)));
  }
}
