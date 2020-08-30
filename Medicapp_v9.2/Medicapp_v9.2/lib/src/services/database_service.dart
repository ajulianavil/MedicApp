import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:componentes/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:componentes/src/models/order_model.dart';
import 'package:componentes/src/models/formula_model.dart';

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

  Future<Map<String, dynamic>> putOrder(
      OrderModel _orderModel) async {
    
        _addOrder(_orderModel);
        
  }

  void _addOrder(OrderModel pedido) async {
    await _firestoreDB
        .collection('pedidos')
        .document(pedido.uid)
        .setData(pedido.toJson());

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

  Future<OrderModel> _getPedido(String uid) async {
    DocumentSnapshot _docReference =
        await _firestoreDB.collection('pedidos').document(uid).get();
    final _orderData = _docReference.data;
    print(_orderData);
    OrderModel pedido = new OrderModel(
      uid: uid,
      applicationDate: _orderData['applicationDate'],
      deliveryAddress: _orderData['deliveryAddress'],
      state: _orderData['state'],
      uidDom: _orderData['uidDom'],
      uidPac: _orderData['uidPac'],
    );

    return pedido;
  }

/////////////////////////////pedidos/////////////////////////
  Future<List<OrderModel>> getOrder(String uid) async {
    final List<OrderModel> myList = new List<OrderModel>();
    final _docReference =
        await _firestoreDB.collection('pedidos').where('uidPac', isEqualTo: uid).getDocuments();
    for (var item in _docReference.documents) {
      myList.add(new OrderModel(
        uid: item.documentID,
        uidPac: item.data['uidPac'],
        uidDom: item.data['uidDom'],
        uidMed: item.data['uidMed'],
        applicationDate: item.data['applicationDate'],
        deliveryAddress: item.data['deliveryAddress'],
        state: item.data['state'],
      ));
    }

    return myList;
  }

  /* formulas */

  Future<List<FormulaModel>> getFormula(String uid) async {
    final List<FormulaModel> myList = new List<FormulaModel>();
    final _docReference = await _firestoreDB
        .collection('formulas')
        .where('uidPac', isEqualTo: uid)
        .getDocuments();
    for (var item in _docReference.documents) {
      myList.add(new FormulaModel(
        uid: item.documentID,
        uidPac: item.data['uidPac'],
        uidMed: item.data['uidMed'],
        authorizationDate: item.data['authorizationDate'],
        nameDoctor: item.data['nameDoctor'],
        observations: item.data['observations'],
        toggle: item.data['toggle'],
      ));
    }

    return myList;
  }

  Future setFormula(FormulaModel item) async {
    return await _firestoreDB
        .collection('formulas')
        .document(item.uid)
        .setData({
      'uidMed': item.uidMed,
      'uidPac': item.uidPac,
      'authorizationDate': item.authorizationDate,
      'nameDoctor': item.nameDoctor,
      'observations': item.observations,
      'toggle': !item.toggle,
    });
  }

  /* Obteniendo un paciente por su uid */
  Future<QuerySnapshot> getPatientbyUID(String uid) async {
    return await _firestoreDB
        .collection('usuarios')
        .where('uid', isEqualTo: uid)
        .getDocuments();
  }

  /* Obteniendo un medicamento por su uid */
  Future<QuerySnapshot> getMedicamentobyUID(String uid) async {
    return await _firestoreDB
        .collection('medicamentos')
        .where('uid', isEqualTo: uid)
        .getDocuments();
  }
}
