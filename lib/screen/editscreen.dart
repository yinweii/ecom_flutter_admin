import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecom_admin/models/product.dart';
import 'package:ecom_admin/provider/products.dart';
import 'package:ecom_admin/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:min_id/min_id.dart';

import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  File file;
  String imageUrl;
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _disCount = TextEditingController();
  TextEditingController _shortInfo = TextEditingController();
  int type;
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  String dropdownValue = 'Pizza';
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                              controller: _title,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'title...',
                              ),
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
                          controller: _shortInfo,
                          maxLines: 2,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Shortinfo...',
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _desc,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Description...',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: getImage,
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
                                child: file == null
                                    ? Icon(
                                        Icons.add_a_photo,
                                        size: 50,
                                        color: Colors.grey[300],
                                      )
                                    : Image.file(
                                        file,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _price,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'giá',
                        ),
                      ),
                      TextFormField(
                        controller: _disCount,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Giảm giá',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void getImage() async {
    final PickedFile imageFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 680, maxWidth: 920);
    setState(() {
      file = File(imageFile.path);
    });
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

  void saveForm() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('Image').child(MinId.getId());
      UploadTask storageUploadTask = ref.putFile(file);
      var imageUrl = await (await storageUploadTask).ref.getDownloadURL();
      imageUrl = imageUrl.toString();
      Provider.of<ProductProvider>(context, listen: false)
          .addNewProduct(
        Product(
          proId: MinId.getId(),
          type: changeType(dropdownValue),
          title: _title.text,
          shortInfo: _shortInfo.text,
          publishedDate: DateTime.now(),
          thumbnailUrl: imageUrl,
          longDescription: _desc.text,
          status: 'Available',
          price: int.parse(_price.text),
          discount: int.parse(_disCount.text),
        ),
      )
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Utils.showToast('Thêm thành công!');
      });
      onClean();
    }
  }

  void onClean() async {
    setState(() {
      file = null;
      _title.clear();
      _shortInfo.clear();
      _desc.clear();
      _price.clear();
      _disCount.clear();
    });
  }
}
