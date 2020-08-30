import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:componentes/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:componentes/src/models/order_model.dart';
import 'package:componentes/src/models/formula_model.dart';

import 'dart:convert';

class DataBaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestoreDB = Firestore.instance;

  Future<Map<String, dynamic>> logInUser(String email, String passwd) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: passwd);

      print(response);
      if (response != null) {
        return {
          "status": 200,
          "message": "Inicio correcto",
          "body": await _getUser(response.user.uid)
        };
      } else {
        return {"status": 400, "message": "No se pudo inicar sesión"};
      }
    } catch (onError) {
      return {"status": 400, "message": onError.toString()};
    }
  }

  Future<Map<String, dynamic>> signInUser(
      UserModel _userModel, String passwd) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: _userModel.email, password: passwd);

      print(response);
      if (response != null) {
        _userModel.uid = response.user.uid;
        _addUser(_userModel);
        return {
          "status": 200,
          "message": "se ha registrado exitosamente",
          "body": await _getUser(_userModel.uid)
        };
      } else {
        return {"status": 400, "message": "No se pudo registrar"};
      }
    } catch (onError) {
      return {"status": 400, "message": onError.toString()};
    }
  }

  void _addUser(UserModel user) async {
    await _firestoreDB
        .collection('usuarios')
        .document(user.uid)
        .setData(user.toJson());
    //await _firestoreDB.collection('pedidos').add(model.toJson());
  }

  Future<UserModel> _getUser(String uid) async {
    DocumentSnapshot _docReference =
        await _firestoreDB.collection('usuarios').document(uid).get();
    final _userData = _docReference.data;
    print(_userData);
    UserModel user = new UserModel(
      uid: uid,
      name: _userData['name'],
      lastName: _userData['lastName'],
      address: _userData['address'],
      bornDate: _userData['bornDate'],
      email: _userData['email'],
      gender: _userData['gender'],
      phone: _userData['phone'],
      rol: _userData['rol'],
    );

    return user;
  }

/////////////////////////////pedidos/////////////////////////
/*   Future<OrderModel> getOrder(String uid) async {
    DocumentSnapshot _docReference =
        await _firestoreDB.collection('pedidos').document(uid).get();
    final _orderData = _docReference.data;
    print(_orderData);
    OrderModel _order = new OrderModel(
      uid: uid,
      uidPac: _orderData['uidPac'],
      uidDom: _orderData['uidDom'],
      applicationDate: _orderData['applicationDate'],
      deliveryAddress: _orderData['deliveryAddress'],
      deliveryDate: _orderData['deliveryDate'],
      state: _orderData['state'],
    );

    return _order;
  } */

  Future<List<OrderModel>> getOrder(String uid) async {
    final List<OrderModel> myList = new List<OrderModel>();
    final _docReference =
        await _firestoreDB.collection('pedidos').getDocuments();
    for (var item in _docReference.documents) {
      myList.add(new OrderModel(
        uid: uid,
        uidPac: item.data['uidPac'],
        uidDom: item.data['uidDom'],
        applicationDate: item.data['applicationDate'],
        deliveryAddress: item.data['deliveryAddress'],
        deliveryDate: item.data['deliveryDate'],
        state: item.data['state'],
      ));
    }

    return myList;
  }

/////////formulas//////////////////
  Future<List<FormulaModel>> getFormula(String uid) async {
    final List<FormulaModel> myList = new List<FormulaModel>();
    final _docReference = await _firestoreDB
        .collection('formulas')
        .where('uidPac', isEqualTo: uid)
        .getDocuments();
    for (var item in _docReference.documents) {
      myList.add(new FormulaModel(
        uid: uid,
        uidPac: item.data['uidPac'],
        uidMed: item.data['uidMed'],
        authorizationDate: item.data['authorizationDate'],
        nameDoctor: item.data['nameDoctor'],
        observations: item.data['observations'],
      ));
    }

    return myList;
  }
    /* Obteniendo un paciente por su uid */
  Future<QuerySnapshot> getPatientbyUID(String uid) async {
    return await _firestoreDB
        .collection('usuarios')
        .where('uid', isEqualTo: uid)
        .getDocuments();
  }
}
