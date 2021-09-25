import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/address.dart';
import 'package:ecom_admin/models/order.dart';
import 'package:ecom_admin/models/product.dart';
import 'package:ecom_admin/models/usermodel.dart';
import 'package:ecom_admin/utils/logger.dart';
import 'package:flutter/foundation.dart';

class Orders with ChangeNotifier {
  final devLog = logger;
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  AddressModel _addressModel;
  AddressModel get addressModel => _addressModel;
  UserModel _userOrder;
  UserModel get userOrder {
    return _userOrder;
  }

  bool checkUser() {
    if (_userOrder != null) {
      return true;
    }
    return false;
  }

  bool checkAddress() {
    if (_addressModel != null) {
      return true;
    }
    return false;
  }

// sdt
  String get phone {
    return checkAddress() ? _addressModel.phoneNumber : 'n/a';
  }

  String get address {
    return checkAddress()
        ? '${_addressModel.hamletNumber}, ${_addressModel.commune}, ${_addressModel.district},${_addressModel.city}'
        : 'n/a';
  }

  // username
  String get username {
    return checkUser() ? _userOrder.name : 'n/a';
  }

  // email
  String get email {
    return checkUser() ? _userOrder.email : 'n/a';
  }

  Future<void> onRefesh(String stutus) async {
    return fetchOrderUser(stutus);
  }

  QuerySnapshot snapshot;
  // get order
  Future<void> fetchOrderUser(String stutus) async {
    setIsLoading(true);
    snapshot = await FirebaseFirestore.instance
        .collection('userorders')
        .where('orderStatus', isEqualTo: stutus)
        .get();
    List<OrderItem> loadData = [];
    snapshot.docs.forEach((document) {
      loadData.add(OrderItem.fromJson(document.data()));
    });
    _orders = loadData;
    setIsLoading(false);
    notifyListeners();
  }

  Future<void> updateOrder(String idOrder, String statusOrder) async {
    try {
      setIsLoading(true);
      snapshot = await FirebaseFirestore.instance
          .collection('userorders')
          .doc(idOrder)
          .update({
        'orderStatus': statusOrder,
      }).then((_) {
        print('UPDATE SUCCESS');
        setIsLoading(false);
      }).catchError(
        (error) => print(
          error.toString(),
        ),
      );

      notifyListeners();
    } catch (e) {
      setIsLoading(false);
      devLog.e(e.toString());
    }
  }

  Future<void> getUserByUid(String orderBy) async {
    try {
      snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: orderBy)
          .get();
      UserModel loadData;
      snapshot.docs.forEach((document) {
        loadData = UserModel.fromJson(document.data());
      });
      _userOrder = loadData;
      notifyListeners();
    } catch (e) {
      devLog.e(e.toString());
    }
  }

  Future<void> getAddressById(String userId, String addressId) async {
    AddressModel loadData;
    try {
      snapshot = await FirebaseFirestore.instance
          .collection('address')
          .doc(userId)
          .collection('userAddress')
          .get();
      snapshot.docs.forEach((document) {
        loadData = AddressModel.fromJson(document.data());
      });
      _addressModel = loadData;
      notifyListeners();
    } catch (e) {
      devLog.e(e.toString());
    }
  }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> acceptOrder() async {}
}
