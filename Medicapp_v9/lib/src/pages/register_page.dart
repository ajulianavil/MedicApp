import 'package:componentes/src/models/user_model.dart';
import 'package:componentes/src/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _date = '';
  String _rol = '';
  String _genero = '';
  final DataBaseService _dbService = new DataBaseService();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  // final TextEditingController rolController = new TextEditingController();
  //final TextEditingController genderController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[_crearFondo(context), _register(context)],
      ),
    );
  }

  Widget _register(BuildContext context) {
    //final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                _crearNombres(),
                _crearApellidos(),
                _crearGenero(),
                _crearDireccion(),
                _crearCelular(),
                _crearFecha(context),
                Divider(),
                _crearRol(),
                _crearEmail(),
                SizedBox(height: 30.0),
                _crearPassword(),
                SizedBox(height: 30.0),
                _crearBoton(),
                SizedBox(height: 15.0),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                        )
                      ]),
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
                          "YA ESTOY REGISTRADO",
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0)
        ],
      ),
    );
  }

/*   Widget _crearNombres() {
    return TextField(
      //  autofocus: true,

      controller: nameController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: 'Ingrese sus nombres',
          labelText: 'Nombres',
          icon: Icon(Icons.account_circle, color: Colors.blue)),

      onChanged: (valor) {
        setState(() {});
      },
    );
  } */
  Widget _crearNombres() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Ingrese sus nombres',
                labelText: 'Nombres',
                icon: Icon(Icons.account_circle, color: Colors.blue)),
            onChanged: (valor) {
              setState(() {});
            },
          ),
        );
      },
    );
  }

  String valuerol = 'Rol';

  Widget _crearRol() {
    return DropdownButton<String>(
      value: valuerol,
      icon: Icon(Icons.arrow_downward, color: Colors.blue),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.grey),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String newValue) {
        setState(() {
          valuerol = newValue;
          _rol = valuerol;
        });
      },
      items: <String>['Rol', 'Administrador', 'Paciente', 'Domiciliario']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  String valuegenero = 'Genero';

  Widget _crearGenero() {
    return DropdownButton<String>(
      value: valuegenero,
      icon: Icon(Icons.arrow_downward, color: Colors.blue),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.grey),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String newValue) {
        setState(() {
          valuegenero = newValue;
          _genero = valuegenero;
        });
      },
      items: <String>['Genero', 'F', 'M', 'O']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _crearApellidos() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //  autofocus: true,
            controller: lastNameController,

            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Ingrese sus apellidos',
                labelText: 'Apellidos',
                icon: Icon(Icons.account_circle, color: Colors.blue)),

            onChanged: (valor) {
              setState(() {});
            },
          ),
        );
      },
    );
  }

  Widget _crearDireccion() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //  autofocus: true,
            controller: addressController,

            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Ingrese su dirección',
                labelText: 'Dirección',
                icon: Icon(Icons.map, color: Colors.blue)),

            onChanged: (valor) {
              setState(() {});
            },
          ),
        );
      },
    );
  }

  Widget _crearCelular() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //  autofocus: true,
            controller: phoneController,

            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Ingrese su número celular',
                labelText: 'Número celular',
                icon: Icon(Icons.phone_android, color: Colors.blue)),

            onChanged: (valor) {
              setState(() {});
            },
          ),
        );
      },
    );
  }

  Widget _crearEmail() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(

                //  autofocus: true,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Ingrese su correo eléctronico',
                    labelText: 'Correo eléctronico',
                    icon: Icon(Icons.email, color: Colors.blue)),
                onChanged: (valor) => setState(() {})));
      },
    );
  }

  Widget _crearPassword() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
                obscureText: true,
                //  autofocus: true,
                controller: passwordController,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Contraseña',
                    labelText: 'Contraseña',
                    icon: Icon(Icons.lock, color: Colors.blue)),
                onChanged: (valor) => setState(() {})));
      },
    );
  }

  _crearFecha(BuildContext context) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                )
              ]),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Fecha de nacimiento'),
              Icon(Icons.calendar_today, color: Colors.blue),
              Text(_date),
            ],
          )),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime(2025),
      //locale: Locale('es', 'Es')
    );

    if (picked != null) {
      setState(() {
        final a = picked.toString().split(' ');
        _date = a[0];
        print(_date);
      });
    }
  }

  Widget _crearBoton() {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      //stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              child: Text('Registrarme'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () async {
              UserModel _user = new UserModel(
                address: addressController.text.trim(),
                email: emailController.text.trim(), //username.text.trim()
                bornDate: _date,
                gender: _genero,
                lastName: lastNameController.text.trim(),
                name: nameController.text.trim(),
                phone: phoneController.text.trim(),
                rol: _rol,
              );

              final response = await _dbService.signInUser(
                  _user, passwordController.text.trim());
              print(response);
              Navigator.pushReplacementNamed(context, '/', arguments: _user);
            }
            //onPressed: snapshot.hasData ? ()=> _login(bloc, context) : null
            );
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xffa55cd4), Color(0xff1a8bc8)],
        stops: [0.0, 0.5],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              SvgPicture.asset("data/logo.svg", width: 100.0),
              // Icon( Icons.person_pin_circle, color: Colors.white, size: 30.0 ),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Registro',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}
