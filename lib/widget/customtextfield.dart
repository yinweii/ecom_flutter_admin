import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;

  CustomTextField(
      {@required this.controller,
      @required this.data,
      @required this.hintText,
      @required this.isObsecure});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: TextFormField(
          controller: controller,
          obscureText: isObsecure,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              data,
              color: Theme.of(context).primaryColor,
            ),
            focusColor: Theme.of(context).primaryColor,
            hintText: hintText,
          ),
        ));
  }
}
