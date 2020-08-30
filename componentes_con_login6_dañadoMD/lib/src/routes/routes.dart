import 'package:componentes/src/pages/admin_main_page.dart';
import 'package:componentes/src/pages/card_page.dart';
import 'package:componentes/src/pages/domiciliario_main_page.dart';
import 'package:componentes/src/pages/emergency_page.dart';
import 'package:componentes/src/pages/input_page.dart';
import 'package:componentes/src/pages/patient_main_page.dart';
import 'package:componentes/src/pages/register_page.dart';
import 'package:componentes/src/pages/revisar_pedidos_admin.dart';
import 'package:componentes/src/pages/solicitar_formula.dart';
import 'package:flutter/material.dart';
import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/pages/avatar_page.dart';
import 'package:componentes/src/pages/home_page.dart';
import 'package:componentes/src/pages/login_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginPage(),
    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'inputs': (BuildContext context) => InputPage(),
    'emergency': (BuildContext context) => EmergencyPage(),
    'home': (BuildContext context) => HomePage(),
    'register': (BuildContext context) => RegisterPage(),
    'paciente': (BuildContext context) => PatientHomePage(),
    'administrador': (BuildContext context) => AdminHomePage(),
    'domiciliario': (BuildContext context) => DomiciliarioHomePage(),
    'formulas': (BuildContext context) => FormulaRequestPage(),
    'pedidos': (BuildContext context) => ReviewOrderPage(),
  };
}
