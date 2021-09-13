import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/product.dart';
import 'package:ecom_admin/utils/logger.dart';

import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  final devLog = logger;
  List<Product> _listProduct = [];
  List<Product> get listProduct => [..._listProduct];
  String _errorMessage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  QuerySnapshot snapshot;

  Future<void> getProduct(int type) async {
    List<Product> loadData = [];

    try {
      snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('type', isEqualTo: type)
          //.orderBy('publishedDate', descending: true)
          .get();
      snapshot.docs.forEach((element) {
        loadData.add(Product.fromJson(element.data()));
      });
      _listProduct = loadData;

      notifyListeners();
    } on SocketException {} catch (e) {
      devLog.e(e.toString());
    }
  }

  Future<void> addNewProduct(Product product) async {
    var newProduct = Product(
        proId: product.proId,
        type: product.type,
        title: product.title,
        shortInfo: product.shortInfo,
        publishedDate: product.publishedDate,
        thumbnailUrl: product.thumbnailUrl,
        longDescription: product.longDescription,
        status: product.status,
        price: product.price,
        discount: product.discount);

    _listProduct.add(newProduct);

    try {
      FirebaseFirestore.instance
          .collection('products')
          .doc(product.proId)
          .set(newProduct.toJson());
      notifyListeners();
    } catch (e) {
      devLog.e(e.toString());
    }
  }

  Future<void> deleteProduct(String id) async {
    final existingProductIndex =
        _listProduct.indexWhere((prod) => prod.proId == id);
    //var existingProduct = _listProduct[existingProductIndex];
    _listProduct.removeAt(existingProductIndex);
    notifyListeners();
    try {
      FirebaseFirestore.instance.collection('products').doc(id).delete();
    } catch (e) {
      devLog.e(e.toString());
    }
    notifyListeners();
  }

  Product fintById(String id) {
    return _listProduct.firstWhere((element) => element.proId == id);
  }

  // void setIsLoading(value) {
  //   _isLoading = value;
  //   notifyListeners();
  // }

  // void setMessage(message) {
  //   _errorMessage = message;
  //   print(_errorMessage);
  //   notifyListeners();
  // }
}
