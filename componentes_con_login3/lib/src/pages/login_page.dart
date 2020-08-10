import 'package:componentes/src/models/user_model.dart';
import 'package:componentes/src/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:componentes/src/services/database_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

//import 'package:formvalidation/src/bloc/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DataBaseService _dbService = new DataBaseService();
  final TextEditingController username = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  String msg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
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
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearImput(),

                ///CAMBIAR ESTO CUANDO PONGAMOS BASE DE DATOS
                SizedBox(height: 30.0),
                _crearPassword(),
                SizedBox(height: 30.0),
                _crearBoton()
              ],
            ),
          ),
          Text('¿Olvido la contraseña?'),
          Container(
            child: Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    "Registrarme",
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.0)
        ],
      ),
    );
  }

  Widget _crearImput() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //  autofocus: true,
            controller: username,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                hintText: 'Nombre de usuario',
                labelText: 'Nombre de usuario',
                helperText: 'solo es el nombre de usuario',
                icon: Icon(Icons.account_circle, color: Colors.blue)),
          ),
        );
      },
    );
  }

  Widget _crearPassword() {
    return StreamBuilder(
      //stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.blue),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            // onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton() {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      //stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          onPressed: () async {
            Map resp = await _dbService.logInUser(
                // iniciar sesion
                username.text.trim(),
                password.text.trim());

            //Map resp;
            UserModel _user = new UserModel(
                address: "Cll 16 # 29-46",
                email: "test@test.com", //username.text.trim()
                bornDate: "10 de Noviembre 1998",
                gender: "F",
                lastName: "Villalba",
                name: "Andrea",
                phone: "3152565743",
                rol: "Adm",
                uid: "ndsjkndsjksdn");

/*             final response =
                await _dbService.signInUser(_user, password.text.trim()); */

            if (resp['status'] == 200) {
              UserModel _user = resp['body'];
              switch (_user.rol) {
                case 'Adm':
                  Navigator.pushReplacementNamed(context, "home",
                      arguments: _user);
                  break;
                default:
                  break;
              }
            } else {
              //Mostrar error de inicio de sesión
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.blue,
          textColor: Colors.white,
/*           onPressed: () => Navigator.pushNamed(context, "alert"),
 */
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
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(0, 106, 252, 0.44),
        Color.fromRGBO(54, 90, 98, 0.32)
      ])),
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
              SvgPicture.asset("data/logo.svg", width: 150.0),
              // Icon( Icons.person_pin_circle, color: Colors.white, size: 30.0 ),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Login',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}
