import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecom_admin/models/product.dart';
import 'package:ecom_admin/provider/products.dart';
import 'package:ecom_admin/utils/logger.dart';
import 'package:ecom_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    Key key,
  }) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  File file;
  String imageUrl;
  int type;

  String dropdownValue = 'Pizza';
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var _isInit = true;
  final devLog = logger;
  //
  final _titleFocus = FocusNode();
  final _shortInfoFocus = FocusNode();
  final _decsFocus = FocusNode();
  final _priceFocus = FocusNode();
  final _discountFocus = FocusNode();

  var _editProduct = Product().copyWith(
      type: 0,
      title: '',
      shortInfo: '',
      longDescription: '',
      price: 0,
      discount: 0);

  //var _editProduct = Product(
  // type: null,
  // title: '',
  // shortInfo: '',
  // publishedDate: null,
  // longDescription: '',
  // status: '',
  // price: null,
  // discount: null
  // );
  var _initValue = {
    'title': '',
    'desc': '',
    'shortInfo': '',
    'price': '',
    'discount': '',
    'imageUrl': '',
  };
  void saveForm() {
    if (_formKey.currentState.validate()) {
      // setState(() {
      //   _isLoading = true;
      // });
      devLog.e(_editProduct);
      // Provider.of<ProductProvider>(context, listen: false)
      //     .updateProduct(_editProduct.proId, _editProduct)
      //     .then((_) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // });
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        //search product by ID
        _editProduct = Provider.of<ProductProvider>(context, listen: false)
            .fintById(productId);
        devLog.e(_editProduct.toString());
        print(_editProduct.title);
        _initValue = {
          'title': _editProduct.title,
          'desc': _editProduct.longDescription,
          'shortInfo': _editProduct.shortInfo,
          'discount': _editProduct.discount.toString(),
          'price': _editProduct.price.toString(),
          'type': dropdownValue,
          'imageUrl': _editProduct.thumbnailUrl,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  String titleEdt = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String priceChange = '';
    String discount = '';
    String toatal = '';

    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton.icon(
              onPressed: saveForm, icon: Icon(Icons.save), label: Text('Save'))
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 2 / 3,
                            child: TextFormField(
                              initialValue: _initValue['title'],
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_shortInfoFocus);
                              },
                              focusNode: _titleFocus,
                              onSaved: (titlevalue) {
                                _editProduct =
                                    Product().copyWith(title: titlevalue);
                                print(_editProduct);
                                // _editProduct = Product().copyWith(
                                //     type: _editProduct.type,
                                //     title: titlevalue,
                                //     shortInfo: _editProduct.shortInfo,
                                //     publishedDate: _editProduct.publishedDate,
                                //     longDescription:
                                //         _editProduct.longDescription,
                                //     price: _editProduct.price,
                                //     discount: _editProduct.discount);
                              },
                            ),
                          ),
                          DropdownButton(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 16,
                            elevation: 16,
                            style: const TextStyle(color: Colors.blue),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                print(dropdownValue);
                              });
                            },
                            items: <String>[
                              'Pizza',
                              'Drink',
                              'Sandwich',
                              'More'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Container(
                        child: TextFormField(
                          initialValue: _initValue['shortInfo'],
                          maxLines: 2,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_decsFocus);
                          },
                          decoration: InputDecoration(
                            hintText: 'Shortinfo...',
                          ),
                          focusNode: _shortInfoFocus,
                          onSaved: (shortInfovalue) {
                            _editProduct = Product().copyWith(
                                type: type,
                                title: _editProduct.title,
                                shortInfo: shortInfovalue,
                                longDescription: _editProduct.longDescription,
                                price: _editProduct.price,
                                discount: _editProduct.discount);
                          },
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          maxLines: 3,
                          initialValue: _initValue['desc'],
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Description...',
                          ),
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_priceFocus);
                          },
                          focusNode: _decsFocus,
                          onSaved: (longDescriptionValue) {
                            _editProduct = Product().copyWith(
                                type: type,
                                title: _editProduct.title,
                                shortInfo: _editProduct.shortInfo,
                                longDescription: longDescriptionValue,
                                price: _editProduct.price,
                                discount: _editProduct.discount);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // get image
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
                            padding: EdgeInsets.all(6),
                            dashPattern: [10, 3, 2, 3],
                            color: Colors.red,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                height: 150,
                                width: width * 2 / 3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      _initValue['imageUrl'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Utils.sizeWidth(context) * 1 / 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                initialValue: _initValue['price'],
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_discountFocus);
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'giá',
                                ),
                                focusNode: _priceFocus,
                                onChanged: (String priceStr) {
                                  setState(() {
                                    priceChange = priceStr;
                                    print(priceChange);
                                  });
                                },
                                onSaved: (priceValue) {
                                  _editProduct = Product().copyWith(
                                      type: type,
                                      title: _editProduct.title,
                                      shortInfo: _editProduct.shortInfo,
                                      longDescription:
                                          _editProduct.longDescription,
                                      price: int.parse(priceValue),
                                      discount: _editProduct.discount);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Value not empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Text(priceChange),
                          Container(
                            width: Utils.sizeWidth(context) * 1 / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                initialValue: _initValue['discount'],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                focusNode: _discountFocus,
                                decoration: InputDecoration(
                                  hintText: 'Giảm giá',
                                ),
                                onChanged: (discountStr) {
                                  setState(() {
                                    discount = discountStr;
                                  });
                                },
                                onSaved: (value) {
                                  _editProduct = Product().copyWith(
                                      type: type,
                                      title: _editProduct.title,
                                      shortInfo: _editProduct.shortInfo,
                                      longDescription:
                                          _editProduct.longDescription,
                                      price: _editProduct.price,
                                      discount: int.parse(value));
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Value not empty';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (_) => saveForm(),
                              ),
                            ),
                          ),
                          Text(priceChange),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  int changeType(String value) {
    if (dropdownValue.contains('Drink')) {
      return type = 1;
    } else if (dropdownValue.contains('Pizza')) {
      return type = 2;
    } else if (dropdownValue.contains('Sandwich')) {
      return type = 3;
    } else if (dropdownValue.contains('More')) {
      return type = 4;
    }
    return type = null;
  }

  // void saveForm() async {
  //   if (_formKey.currentState.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     Provider.of<ProductProvider>(context, listen: false)
  //         .updateProduct(_editProduct.proId, _editProduct);
  //   }

  // void getImage() async {
  //   final PickedFile imageFile = await ImagePicker()
  //       .getImage(source: ImageSource.gallery, maxHeight: 680, maxWidth: 920);
  //   setState(() {
  //     file = File(imageFile.path);
  //   });
  // }
}
