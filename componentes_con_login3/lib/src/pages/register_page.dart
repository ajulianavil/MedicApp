import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _nombre = '';
  String _apellido = '';
  String _direccion = '';
  String _email = '';
  String _fecha = '';

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrarse'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        children: <Widget>[
          _crearNombres(),
          _crearApellidos(),
          _crearDireccion(),
          _crearCelular(),
          _crearFecha(context),
          Divider(),
          _crearEmail(),
          _crearPassword(),
          SizedBox(height: 30.0),
          _crearBoton(),
        ],
      ),
    );
  }

  Widget _crearNombres() {
    return TextField(
      //  autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: 'Ingrese sus nombres',
          labelText: 'Nombres',
          icon: Icon(Icons.account_circle)),

      onChanged: (valor) {
        setState(() {
          _nombre = valor;
          print(_nombre);
        });
      },
    );
  }

  Widget _crearApellidos() {
    return TextField(
      //  autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: 'Ingrese sus apellidos',
          labelText: 'Apellidos',
          icon: Icon(Icons.account_circle)),

      onChanged: (valor) {
        setState(() {
          _apellido = valor;
          print(_apellido);
        });
      },
    );
  }

  Widget _crearDireccion() {
    return TextField(
      //  autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: 'Ingrese su dirección',
          labelText: 'Dirección',
          icon: Icon(Icons.map)),

      onChanged: (valor) {
        setState(() {
          _direccion = valor;
          print(_direccion);
        });
      },
    );
  }

  Widget _crearCelular() {
    return TextField(
      //  autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: 'Ingrese su número celular',
          labelText: 'Número celular',
          icon: Icon(Icons.phone_android)),

      onChanged: (valor) {
        setState(() {
          _direccion = valor;
          print(_direccion);
        });
      },
    );
  }

  Widget _crearPersona() {
    return ListTile(
      title: Text('Nombre es:  $_nombre'),
      subtitle: Text('Email:$_email'),
    );
  }

  Widget _crearEmail() {
    return TextField(
        //  autofocus: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: 'Ingrese su correo eléctronico',
            labelText: 'Correo eléctronico',
            icon: Icon(Icons.email)),
        onChanged: (valor) => setState(() {
              _email = valor;
            }));
  }

  Widget _crearPassword() {
    return TextField(
        obscureText: true,
        //  autofocus: true,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
            icon: Icon(Icons.lock)),
        onChanged: (valor) => setState(() {
              _email = valor;
            }));
  }

  _crearFecha(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      //  autofocus: true,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: 'Fecha nacimiento',
          labelText: 'Fecha nacimiento',
          icon: Icon(Icons.calendar_today)),
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
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      //locale: Locale('es', 'Es')
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.blue,
          textColor: Colors.white, onPressed: () {},
          //onPressed: snapshot.hasData ? ()=> _login(bloc, context) : null
        );
      },
    );
  }
}
