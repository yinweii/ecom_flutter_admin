import 'package:flutter/material.dart';

class TextFieldCusTom extends StatelessWidget {
  const TextFieldCusTom(
      {Key key, this.controller, this.hintext, this.keyInput, this.maxLine})
      : super(key: key);
  final TextEditingController controller;
  final TextInputType keyInput;
  final String hintext;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.teal),
      controller: controller,
      keyboardType: keyInput,
      decoration: InputDecoration(
        hintText: hintext,
        hintStyle: TextStyle(color: Colors.teal),
        border: InputBorder.none,
      ),
    );
  }
}
